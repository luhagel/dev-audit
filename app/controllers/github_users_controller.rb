# Github Users Controller
class GithubUsersController < ApplicationController
  include GithubUsersHelper

  def create
    @githubuser = GithubUser.new(githubuser_params)

    if @githubuser.save
      redirect_to root_path
    end
  end

  private

  def githubuser_params
    params.require(:login, :developer_id)
  end
end
