class DevelopersController < ApplicationController
  include DevelopersHelper

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
    #if !checkFor404("https://github.com/" + @developer.username + ":80")
      gitGraph = getContribGraph(@developer.username)
      @developer.git_graph_html = gitGraph
      if @developer.save
        redirect_to [@team, @developer]
      end
   # end
  end

  def show
    @team = Team.find(params[:team_id])
    @developer = Developer.find(params[:id])
    #@developer.git_graph_html = getContribGraph(@developer.username)
  end

  private
  def developer_params
    params.require(:developer).permit(:name, :username, :git_graph_html, :team_id)
  end
end
