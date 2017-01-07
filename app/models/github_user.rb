class GithubUser < ApplicationRecord
  belongs_to :developer

  validates :login, presence: true
end
