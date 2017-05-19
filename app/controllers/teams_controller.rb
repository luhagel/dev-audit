class TeamsController < ApplicationController
  include TeamsHelper
  before_action :require_login, only: [:index, :new, :create]

  layout :team_layout

  def show
    @team = Team.find(params[:id])

    if !logged_in?  && !public?(@team)
      flash[:error] = "You must be logged in to view this private team!"
      redirect_to login_url
    elsif !owner?(@team) && !public?(@team)
      render '_not_owner'
    else
      @developers = @team.developers

      if params[:group]
        @developers = @developers.by_group(params[:group], @team.groups).sort { |a, b| b.github_user.contributions.reduce(0, :+) <=> a.github_user.contributions.reduce(0, :+) }
      end

      if params[:hide_hired]
        @developers = @developers.where("github_users.hireable = ?", true).references(:github_users).sort { |a, b| b.github_user.contributions.reduce(0, :+) <=> a.github_user.contributions.reduce(0, :+) }
      end

      if params[:search]
         @developers = @developers.search(params[:search]).references(:github_users).sort { |a, b| b.github_user.contributions.reduce(0, :+) <=> a.github_user.contributions.reduce(0, :+) }
      end
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

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(team_params)
      redirect_to @team
    else
      render 'edit'
    end
  end

  def destroy
    @team = Team.find(params[:id])

    memberships = Membership.where(["team_id = ?", @team.id])

    memberships.destroy_all unless memberships.nil?

    @team.destroy

    redirect_to root_path
  end

  private
  def team_params
    params.require(:team).permit(:name, :user_id, :is_public, :groups)
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_url
    end
  end

  def team_layout
    params[:presentation] ? "presentation" : "application"
  end
end
