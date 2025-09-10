FactoryBot.define do
  factory :tenant_user do
    association :user
    association :tenant
  end
end
