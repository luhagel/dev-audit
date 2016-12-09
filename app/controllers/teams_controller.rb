class TeamsController < ApplicationController
  include TeamsHelper
  before_action :require_login, only: [:index, :new, :create]

  def index
    @teams = current_user.teams
  end

  def show
    @team = Team.find(params[:id])

    if !logged_in?  && !@team.is_public
      flash[:error] = "You must be logged in to view this private team!"
      redirect_to login_url
    elsif !is_owner?(@team) && !@team.is_public
      render 'shared/not_owner'
    else 
      @developers = @team.developers
    end
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
    params.require(:team).permit(:name, :user_id, :is_public)
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_url
    end
  end
end
