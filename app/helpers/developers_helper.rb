module DevelopersHelper
  include ActionView::Helpers::OutputSafetyHelper

  def owner?(team)
    current_user == team.user && !current_user.nil?
  end
end
