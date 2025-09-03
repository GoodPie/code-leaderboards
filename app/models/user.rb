class User < ApplicationRecord
  has_secure_password

  has_many :sessions, dependent: :destroy
  has_many :solutions, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :achievements
  has_many :challenges, through: :solutions

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  scope :active, -> { joins(:solutions).where(solutions: { submitted_at: 30.days.ago.. }).distinct }

  has_one_attached :avatar, dependent: :destroy

  def current_streak

  end

  def total_points

  end

end
