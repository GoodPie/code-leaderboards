class TenantUserRole < ApplicationRecord
  belongs_to :tenant_user
  belongs_to :role
  belongs_to :tenant
end
