FactoryBot.define do
  factory :user do
    sequence(:email_address) { |n| "user#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    first_name { "Test" }
    last_name { "User" }
    github_username { "testuser" }
    bio { "Test user bio" }
    joined_at { Time.current }
    avatar_url { nil }
  end
end
