class User < ApplicationRecord
  has_secure_password

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_many :sessions
  has_many :solutions
  has_many :votes
  has_many :achievements
  has_many :challenges, through: :solutions

  has_many :tenant_user_roles
  has_many :tenants, through: :tenant_user_roles
  has_many :roles, through: :tenant_user_roles

  scope :active, -> { joins(:solutions).where(solutions: { submitted_at: 30.days.ago.. }).distinct }

  has_one_attached :avatar

  def current_streak
    return 0 if solutions.empty?

    solutions.order(submitted_at: :desc).pluck(:id).each_cons(2).count { |a, b| a + 1 == b }
  end

  def role_for(tenant)
    tenant_user_roles.find_by(tenant: tenant).role
  end

  def total_points
  end
end
