class Team < ApplicationRecord
  has_many :developers

  validates :name, presence: true
end
