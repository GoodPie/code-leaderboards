class Role < ApplicationRecord
  has_many :tenant_user_roles, dependent: :destroy
  has_many :tenant_users, through: :tenant_user_roles
  has_many :tenants, through: :tenant_users
  has_many :users, through: :tenant_users

  validates :name, presence: true, uniqueness: true
end
