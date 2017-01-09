class DevelopersController < ApplicationController
  include DevelopersHelper

  before_action :require_login

  def new
    @team = Team.find(params[:team_id])
    @developer = Developer.new
  end

  def create
    @team = Team.find(params[:team_id])
    @developer = Developer.new(developer_params)

    if @developer.save
      @githubuser = GithubUser.create(login: @developer.username, developer_id: @developer.id)
      @githubuser.pull_github_data
      @githubuser.save

      @developer.memberships.create(team: @team)

      redirect_to [@team, @developer]
    end
  end

  def show
    @team = Team.find(params[:team_id])
    @developer = Developer.find(params[:id])
  end

  private

  def developer_params
    params.require(:developer).permit(:username, :team_id)
  end

  def require_login
    unless logged_in?
      flash[:error] = 'You must be logged in to access this section'
      redirect_to login_url
    end
  end
end
