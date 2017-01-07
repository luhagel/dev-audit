class Developer < ApplicationRecord
  belongs_to :team

  has_one :github_user

  validates :github_user_id, presence: true
end
