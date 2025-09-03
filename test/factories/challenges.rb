FactoryBot.define do
  factory :challenge do
    sequence(:title) { |n| "Challenge #{n}" }
    description { "Sample challenge" }
    start_date { Time.current }
    end_date { Time.current + 1.day }
    difficulty { 1 }
    starter_code { "puts :start" }
    test_suite { "assert true" }
  end
end
