class DevelopersController < ApplicationController
  include DevelopersHelper

  before_action :require_login

  def index
    @developers = Developer.all
  end

  def new
    @team = Team.find(params[:team_id])
    @developer = Developer.new
  end

  def create
    @team = Team.find(params[:team_id])
    @developer = Developer.new(developer_params)
    @developer.team = @team
    git_graph = get_contrib_graph(@developer.username)
    @developer.git_graph_html = git_graph
    redirect_to [@team, @developer] if @developer.save
  end

  def show
    @team = Team.find(params[:team_id])
    @developer = Developer.find(params[:id])
  end

  private

  def developer_params
    params.require(:developer).permit(:name, :username, :git_graph_html, :team_id)
  end

  def require_login
    unless logged_in?
      flash[:error] = 'You must be logged in to access this section'
      redirect_to login_url
    end
  end
end
