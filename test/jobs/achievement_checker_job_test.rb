require "test_helper"

class AchievementCheckerJobTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @other_user = create(:user)
    @challenge = create(:challenge)
  end

  teardown do
    Achievement.delete_all
    Solution.delete_all
  end

  def perform_job(solution)
    AchievementCheckerJob.perform_now(solution)
  end

  def capture_broadcasts
    calls = []
    stub = ->(*args, **kwargs) { calls << { args: args, kwargs: kwargs } }
    Turbo::StreamsChannel.stub(:broadcast_prepend_to, stub) do
      yield calls
    end
  end

  def broadcast_contains_achievement(calls, achievement_type)
    return false unless calls.any?
    calls.any? { |call| call[:kwargs][:locals][:achievement].achievement_type == achievement_type }
  end

  def broadcast_achievement_count(calls, achievement_type)
    return false unless calls.any?
    calls.filter { |call| call[:kwargs][:locals][:achievement].achievement_type == achievement_type }.length
  end

  test "uses low_priority queue" do
    assert_equal :low_priority, AchievementCheckerJob.queue_name.to_sym
  end

  test "awards first_blood to first solution of a challenge and broadcasts" do
    first_solution = create(:solution, user: @user, challenge: @challenge, code: "puts 1", lines_of_code: 10, execution_time: 0.01, submitted_at: Time.current - 5.minutes, github_url: "http://example.com/1")

    capture_broadcasts do |calls|
      assert_difference -> { Achievement.where(user: @user, achievement_type: "first_blood").count }, +1 do
        perform_job(first_solution)
      end

      assert_equal 2, calls.size
      payload = calls.first
      assert_equal [ "achievements" ], payload[:args]
      assert_equal "notifications", payload[:kwargs][:target]
      assert_equal "achievements/notification", payload[:kwargs][:partial]
      assert_instance_of Achievement, payload[:kwargs][:locals][:achievement]

      achievement = Achievement.where(user: @user, achievement_type: "first_blood").order(:created_at).last
      assert_equal @challenge, achievement.challenge
      assert_equal first_solution.id, achievement.metadata["solution_id"]
    end
  end


  test "awards speed_demon when execution_time < 1ms" do
    sol = create(:solution, user: @user, challenge: @challenge, code: "x", lines_of_code: 10, execution_time: 0.0009, submitted_at: Time.current, github_url: "http://example.com/speed")

    capture_broadcasts do |calls|
      assert_difference -> { Achievement.where(user: @user, achievement_type: "speed_demon").count }, +1 do
        perform_job(sol)
      end
      assert broadcast_contains_achievement(calls, "speed_demon")
    end
  end

  test "assert broadcast doesn't contain incorrect" do
    sol = create(:solution, user: @user, challenge: @challenge, code: "x", lines_of_code: 10, execution_time: 0.0009, submitted_at: Time.current, github_url: "http://example.com/speed")

    capture_broadcasts do |calls|
      assert_difference -> { Achievement.where(user: @user, achievement_type: "speed_demon").count }, +1 do
        perform_job(sol)
      end
      assert_not broadcast_contains_achievement(calls, "code_golfer")
      assert_not broadcast_contains_achievement(calls, "random")
      assert broadcast_contains_achievement(calls, "speed_demon")
    end
  end

  test "awards code_golfer when lines_of_code <= 5" do
    sol = create(:solution, user: @user, challenge: @challenge, code: "puts :ok", lines_of_code: 5, execution_time: 0.5, submitted_at: Time.current, github_url: "http://example.com/golf")

    capture_broadcasts do |calls|
      assert_difference -> { Achievement.where(user: @user, achievement_type: "code_golfer").count }, +1 do
        perform_job(sol)
      end
      assert broadcast_contains_achievement(calls, "code_golfer")
    end
  end

  test "awards night_owl when submitted between midnight and 6 AM" do
    time = Time.current.change(hour: 3, min: 0)
    sol = create(:solution, user: @user, challenge: @challenge, code: "puts :zzz", lines_of_code: 10, execution_time: 0.5, submitted_at: time, github_url: "http://example.com/night")

    capture_broadcasts do |calls|
      assert_difference -> { Achievement.where(user: @user, achievement_type: "night_owl").count }, +1 do
        perform_job(sol)
      end
      assert broadcast_contains_achievement(calls, "night_owl")
    end
  end

  test "awards streak_keeper when current_streak >= 3" do
    sol = create(:solution, user: @user, challenge: @challenge, code: "puts :streak", lines_of_code: 10, execution_time: 0.5, submitted_at: Time.current, github_url: "http://example.com/streak")

    @user.stub(:current_streak, 3) do
      capture_broadcasts do |calls|
        assert_difference -> { Achievement.where(user: @user, achievement_type: "streak_keeper").count }, +1 do
          perform_job(sol)
        end
        assert_equal 3, calls.size
      end
    end
  end

  test "awards perfectionist when more than one solution for same challenge" do
    first = create(:solution, user: @user, challenge: @challenge, code: "puts :a", lines_of_code: 10, execution_time: 0.5, submitted_at: Time.current - 10.minutes, github_url: "http://example.com/a")
    second = create(:solution, user: @user, challenge: @challenge, code: "puts :b", lines_of_code: 10, execution_time: 0.5, submitted_at: Time.current - 5.minutes, github_url: "http://example.com/b")

    capture_broadcasts do |calls|
      assert_difference -> { Achievement.where(user: @user, achievement_type: "perfectionist").count }, +1 do
        perform_job(second)
      end
      assert broadcast_contains_achievement(calls, "perfectionist")
    end
  end
end
