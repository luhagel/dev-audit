class Developer < ApplicationRecord
  has_many :memberships
  has_many :teams, through: :memberships

  has_one :github_user

  validates :username, presence: true
end
