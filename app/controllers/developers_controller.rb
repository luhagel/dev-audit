class DevelopersController < ApplicationController
  include DevelopersHelper

  def index
    @developers = Developer.all
  end

  def new
    @developer = Developer.new
  end

  def create
    @developer = Developer.new(developer_params)
    #if !checkFor404("https://github.com/" + @developer.username + ":80")
      gitGraph = getContribGraph(@developer.username)
      @developer.git_graph_html = gitGraph
      if @developer.save
        redirect_to @developer
      end
   # end
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
