class TeamsController < ApplicationController
  before_action :require_login

  def index
    @teams = current_user.teams
  end

  def show
    @team = Team.find(params[:id])
    @developers = @team.developers
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.create(team_params)
    @team.user = current_user
    if @team.save
      redirect_to @team
    else
      redirect_to new_team_path
    end
  end

  private
  def team_params
    params.require(:team).permit(:name, :user_id)
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_url
    end
  end
end
