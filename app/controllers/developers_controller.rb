class DevelopersController < ApplicationController
  include DevelopersHelper

  before_action :require_login, only: [:new, :create, :destroy]
  before_action :require_ownership, only: [:destroy]

  def new
    @team = Team.find(params[:team_id])
    @developer = Developer.new
  end

  def create
    @team = Team.find(params[:team_id])
    @developer = Developer.new(developer_params)
    if Developer.where("username = ?", @developer.username)
      Developer.where("username = ?", @developer.username).first.memberships.create(team: @team)

      redirect_to [@team]

    elsif @developer.save
      @githubuser = GithubUser.create(login: @developer.username, developer_id: @developer.id)
      @githubuser.pull_github_data
      @githubuser.save

      @developer.memberships.create(team: @team)

      redirect_to [@team]
    end
  end

  def show
    @team = Team.find(params[:team_id])
    @developer = Developer.find(params[:id])
  end

  def destroy
    @team = Team.find(params[:team_id])
    Developer.find(params[:id]).destroy
    redirect_to @team
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

  def require_ownership
    @team = Team.find(params[:team_id])
    redirect_to @team unless owner?(@team)
  end
end
