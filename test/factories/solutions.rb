FactoryBot.define do
  factory :solution do
    association :user
    association :challenge
    code { "puts :ok" }
    lines_of_code { 10 }
    execution_time { 0.5 }
    submitted_at { Time.current }
    sequence(:github_url) { |n| "https://example.com/solutions/#{n}" }
  end
end
