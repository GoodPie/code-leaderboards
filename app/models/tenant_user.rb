class TenantUser < ApplicationRecord
  belongs_to :user
  belongs_to :tenant

  has_many :tenant_user_roles, dependent: :destroy
  has_many :roles, through: :tenant_user_roles
end
