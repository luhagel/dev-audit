class DevelopersController < ApplicationController
  def index
    @developers = Developer.all
  end

  def new
    @developer = Developer.new
  end

  def create
    @developer = Developer.new(developer_params)
    if @developer.save
      redirect_to @developer
    end
  end

  def show
    @developer = Developer.find(params[:id])
  end

  private
  def developer_params
    params.require(:developer).permit(:name, :username)
  end
end
