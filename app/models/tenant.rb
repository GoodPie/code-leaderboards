class Tenant < ApplicationRecord
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true, length: { minimum: 3, maximum: 10 }

  has_one_attached :logo

  has_many :tenant_user_roles, dependent: :destroy
  has_many :users, through: :tenant_user_roles

  belongs_to :owner, class_name: "User"

  def add_user(user, role: :member)
    tenant_user_roles.create(user:, role: Role.find_by(name: role))
  end
end
