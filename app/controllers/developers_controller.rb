class DevelopersController < ApplicationController
  include DevelopersHelper

  def index
    @developers = Developer.all
    # @developers.each do |dev|
    #   dev.git_graph_html = getContribGraph(dev.username)
    # end
  end

  def new
    @developer = Developer.new
  end

  def create
    @developer = Developer.new(developer_params)
    gitGraph = getContribGraph(@developer.username)
    @developer.git_graph_html = gitGraph
    if @developer.save
      redirect_to @developer
    end
  end

  def show
    @developer = Developer.find(params[:id])
    #@developer.git_graph_html = getContribGraph(@developer.username)
  end

  private
  def developer_params
    params.require(:developer).permit(:name, :username, :git_graph_html)
  end
end
