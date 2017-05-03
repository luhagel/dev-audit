class DevelopersController < ApplicationController
  include DevelopersHelper

  before_action :require_login, only: [:new, :create, :destroy]
  before_action :require_ownership, only: [:destroy]

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

    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWIITER_CONSUMER_SECRET']
      config.access_token        = ENV['TWIITER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWIITER_ACCESS_SECRET']
    end
    unless @developer.twitter_username == ''
      @recent_tweets = []
      @twitter_user = twitter_client.user(@developer.twitter_username)
      twitter_client.user_timeline(@developer.twitter_username)[0..4].each do |tweet|
        @recent_tweets += [twitter_client.status(tweet.id)]
      end
    end
    unless @developer.medium_username == ''
      @recent_stories = []

      # Disable Medium for now
      # begin
      #   @recent_stories = MediumScraper::Post.latest @developer.medium_username
      # rescue JSON::ParserError
      #   $stderr.print 'json parsing error'
      #   @recent_stories = []
      #   @recent_stories[:user] = []
      #   @recent_stories[:user][:total_posts] = 0
      # end
    end

  end

  def destroy
    @team = Team.find(params[:team_id])
    @developer = Developer.find(params[:id])

    Membership.destroy(Membership.where(["developer_id = ? and team_id = ?", @developer.id, @team.id]).first)

    @developer.destroy if @developer.memberships.count.zero?

    redirect_to @team
  end

  private

  def developer_params
    params.require(:developer).permit(:username, :team_id)
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
end
