class TenantUserRole < ApplicationRecord
  belongs_to :tenant_user
  belongs_to :role
end
