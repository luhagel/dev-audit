class Team < ApplicationRecord
  belongs_to :user

  has_many :memberships
  has_many :developers, through: :memberships

  validates :name, presence: true
end
