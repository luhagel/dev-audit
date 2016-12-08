class Team < ApplicationRecord
  has_many :developers

  belongs_to :user

  validates :name, presence: true
end
