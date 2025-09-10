FactoryBot.define do
  factory :tenant do
    sequence(:slug) { |n| "tenant#{n}" }
    name { "MyString" }
    logo_url { "logo_url" }
  end
end
