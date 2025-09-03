FactoryBot.define do
  factory :vote do
    association :user
    association :solution
    vote_type { "upvote" }
  end
end
