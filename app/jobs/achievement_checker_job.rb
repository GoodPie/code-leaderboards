class AchievementCheckerJob < ApplicationJob
  queue_as :low_priority

  ACHIEVEMENT_RULES = {
    first_blood: ->(solution) {
      solution == solution.challenge.solutions.order(:submitted_at).first
    },
    speed_demon: ->(solution) {
      solution.execution_time && solution.execution_time < 0.001
    },
    code_golfer: ->(solution) {
      solution.lines_of_code <= 5
    },
    night_owl: ->(solution) {
      solution.submitted_at.hour.between?(0, 6)
    },
    streak_keeper: ->(solution) {
      solution.user.current_streak >= 3
    },
    perfectionist: ->(solution) {
      solution.user.solutions.where(challenge: solution.challenge).count > 1
    }
  }.freeze

  # @param [Solution] solution
  # @return [void]
  def perform(solution)
    ACHIEVEMENT_RULES.each do |type, rule|
      next unless rule.call(solution)

      # Create achievement
      achievement = create_achievement(solution, type)

      # Broadcast achievement notification
      broadcast_achievement(achievement)
    end
  end

  # @param [Solution] solution
  # @param [String] achievement_type
  # @return [Achievement]
  def create_achievement(solution, achievement_type)
    solution.user.achievements.create!(
      achievement_type:,
      challenge: solution.challenge,
      unlocked_at: Time.current,
      metadata: { solution_id: solution.id }
    )
  end

  private

  # @param [Achievement] achievement
  # @return [void]
  def broadcast_achievement(achievement)
    Turbo::StreamsChannel.broadcast_prepend_to(
      "achievements",
      target: "notifications",
      partial: "achievements/notification",
      locals: { achievement: achievement }
    )
  end
end
