module DevelopersHelper
  include ActionView::Helpers::OutputSafetyHelper

  def owner?(team)
    current_user == team.user && !current_user.nil?
  end

  def find_all_account_matches
    @developers = Developer.all
    @developers.each do |dev|
      find_account_matches dev
    end
  end

  def find_account_matches(dev)
    if exists?('https://twitter.com/' + dev.username) && dev.twitter_username == ''
      dev.twitter_username = dev.username
    end
    if exists?('https://medium.com/@' + dev.username) && dev.medium_username == ''
      dev.medium_username = dev.username
    end
    dev.save
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
