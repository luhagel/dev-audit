class GithubUsersController < ApplicationController
  include GithubUsersHelper

  def create
    @githubuser = GithubUser.new
    user_data = Octokit.user githubuser_params

    @githubuser.login = user_data.login
    @githubuser.user_id = user_data.id
    @githubuser.name = user_data.name
    @githubuser.company = user_data.company
    @githubuser.blog = user_data.blog
    @githubuser.location = user_data.location
    @githubuser.email = user_data.email
    @githubuser.hireable = user_data.hireable
    @githubuser.bio = user_data.bio
    @githubuser.public_repos = user_data.public_repos
    @githubuser.public_gists = user_data.public_gists
    @githubuser.followers = user_data.followers
    @githubuser.following = user_data.following

    @githubuser.contributions = get_contrib_data(user_data.login)

    @githubuser.save

    redirect_to root_path
  end

  private

  def githubuser_params
    params.require(:username)
  end
end
