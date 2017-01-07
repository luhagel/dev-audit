class Team < ApplicationRecord
  belongs_to :user

  has_many :developers

  validates :name, presence: true
end
