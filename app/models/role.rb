class Role < ApplicationRecord
  has_many :tenant_user_roles, dependent: :destroy
  has_many :tenants, through: :tenant_user_roles
  has_many :users, through: :tenant_user_roles

  enum :name, {
    owner: "owner",
    admin: "admin",
    member: "member",
    guest: "guest"
  }

  validates :name, presence: true, uniqueness: true
end
