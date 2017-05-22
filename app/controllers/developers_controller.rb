
class DevelopersController < ApplicationController
  include DevelopersHelper

  layout :dev_layout

  before_action :require_login, only: [:new, :create, :destroy]
  before_action :require_ownership, only: [:destroy, :edit, :update]

  def new
    @team = Team.find(params[:team_id])
    @developer = Developer.new
  end

  def create
    @team = Team.find(params[:team_id])
    @developer = Developer.new(developer_params)
    if exists?('https://github.com/' + @developer.username)
      existing_dev = Developer
                     .where(['username = ?', @developer.username])
                     .first

      if !existing_dev
        if @developer.save
          @githubuser = GithubUser.create(login: @developer.username,
                                          developer_id: @developer.id)
          @githubuser.pull_github_data
          @githubuser.save

          find_account_matches @developer

          @developer.memberships.create(team: @team)
        end
      else
        existing_dev.memberships.create(team: @team)
      end
      redirect_to [@team]
    else
      render 'new'
    end
  end

  def show
    @team = Team.find(params[:team_id])             
    @developer = Developer.find(params[:id])

    unless @developer.twitter_username == ''
      @recent_tweets = get_tweets(@developer)
    end
  end

  def edit
    @developer = Developer.find(params[:id])
  end

  def update
    @team = Team.find(params[:team_id])
    @developer = Developer.find(params[:id])
    if @developer.update_attributes(developer_params)
      redirect_to [@team, @developer]
    else
      render 'edit'
    end
  end

  def destroy
    @team = Team.find(params[:team_id])
    @developer = Developer.find(params[:id])

    Membership.destroy(Membership.where(["developer_id = ? and team_id = ?", @developer.id, @team.id]).first.id)

    @developer.destroy if @developer.memberships.count.zero?

    redirect_to @team
  end

  private

  def developer_params
    params.require(:developer).permit(:username,
                                      :team_id,
                                      :medium_username,
                                      :twitter_username,
                                      :resume_link,
                                      :email,
                                      :instructor_recommendation,
                                      :bio)
  end

  def require_login
    unless logged_in?
      flash[:error] = 'You must be logged in to access this section'
      redirect_to login_url
    end
  end

  def require_ownership
    @team = Team.find(params[:team_id])
    redirect_to @team unless owner?(@team)
  end

  def exists?(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    puts response.code.to_s + ': ' + url
    response.code.to_i == 200
  end

  def get_tweets(developer)
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWIITER_CONSUMER_SECRET']
      config.access_token        = ENV['TWIITER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWIITER_ACCESS_SECRET']
    end

    recent_tweets = []
    @twitter_user = twitter_client.user(developer.twitter_username)
    twitter_client.user_timeline(developer.twitter_username)[0..2].each do |tweet|
      recent_tweets += [twitter_client.status(tweet.id)]
    end

    @recent_tweets
  end

  def dev_layout
    if cookies['pres_mode'] == 'true' or params[:presentation]
      cookies[:pres_mode] = {
        value: 'true'
      }
      return 'presentation'
    end

    return 'application'
  end
end
