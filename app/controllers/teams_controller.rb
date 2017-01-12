class TeamsController < ApplicationController
  include TeamsHelper
  before_action :require_login, only: [:index, :new, :create]

  def show
    @team = Team.find(params[:id])

    if !logged_in?  && !public?(@team)
      flash[:error] = "You must be logged in to view this private team!"
      redirect_to login_url
    elsif !owner?(@team) && !public?(@team)
      render '_not_owner'
    else
      @developers = @team.developers.sort { |a, b| a.username.downcase <=> b.username.downcase }
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

  def destroy
    @team = Team.find(params[:id])

    Membership.destroy(Membership.where(["team_id = ?", @team.id]))

    @team.destroy

    redirect_to root_path
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
