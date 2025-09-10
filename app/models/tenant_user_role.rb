class TenantUserRole < ApplicationRecord
  belongs_to :tenant
  belongs_to :user
  belongs_to :role
end
