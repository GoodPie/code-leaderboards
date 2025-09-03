FactoryBot.define do
  factory :tenant_user_role do
    association :tenant_user
    association :role
  end
end
