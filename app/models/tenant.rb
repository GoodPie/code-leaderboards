class Tenant < ApplicationRecord
  validate :name, presence: true
  validate :slug, presence: true, uniqueness: true, length: { minimum: 3, maximum: 10 }

  has_one_attached :logo

  has_many :tenant_users
  has_many :users, through: :tenant_users

  belongs_to :owner, class_name: "User"
end
