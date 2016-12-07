class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    @developers = @team.developers
  end

  def new
  end

  def create
  end
end
