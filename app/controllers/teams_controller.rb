class TeamsController < ApplicationController
  def index
    @teams = Team.all
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
    if @team.save
      redirect_to @team
    else
      redirect_to new_team_path
    end
  end

  private
  def team_params
    params.require(:team).permit(:name)
  end
end
