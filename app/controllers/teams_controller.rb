class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    @developers = Developer.all
  end

  def new
  end

  def create
  end
end
