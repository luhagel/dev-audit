# Github User
class GithubUser < ApplicationRecord
  include GithubUsersHelper
  belongs_to :developer

  validates :login, presence: true

  def pull_github_data
    gh_client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
    user_data = gh_client.user login
    puts user_data.email

    self.user_id = user_data.id
    self.name = user_data.name
    self.company = user_data.company
    self.blog = user_data.blog
    self.location = user_data.location
    self.email = user_data.email
    self.hireable = user_data.hireable
    self.bio = user_data.bio
    self.public_repos = user_data.public_repos
    self.public_gists = user_data.public_gists
    self.followers = user_data.followers
    self.following = user_data.following

    self.contributions = get_contrib_data(user_data.login)
    self.prefered_languages = get_prefered_languages(user_data.login).to_a
  end
end
