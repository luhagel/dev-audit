class GithubUser < ApplicationRecord
  validates :login, presence: true
end
