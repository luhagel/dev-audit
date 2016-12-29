class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  @public_teams = Team.all
end
