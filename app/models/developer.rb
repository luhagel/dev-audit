class Developer < ApplicationRecord
  belongs_to :team

  has_one :github_user
end
