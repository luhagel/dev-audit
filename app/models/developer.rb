class Developer < ApplicationRecord
  has_many :memberships
  has_many :teams, through: :memberships

  has_one :github_user, dependent: :destroy

  validates :username, presence: true
end

