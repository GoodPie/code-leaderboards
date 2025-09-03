class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :challenge
  has_many :votes, dependent: :destroy

  has_one_attached :screenshot, dependent: :destroy

  broadcasts_refreshes

  after_create_commit :analyze_solution
  after_create_commit :check_achievements

  scope :recent, -> { order(submitted_at: :desc) }

  private

  def analyze_solution

  end

  def check_achievements

  end
end
