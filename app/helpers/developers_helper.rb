module DevelopersHelper
  include ActionView::Helpers::OutputSafetyHelper

  def update_all_developer_info
    @developers = Developer.all
    save_counter = 0
    @developers.each do |dev|
      dev.git_graph_html = get_contrib_graph(dev.username)
      save_counter += 1 if dev.save
    end
    puts 'SUCCESS: Updated ' + String(save_counter) + '/' + String(@developers.count) + ' Developers!'
  end

  def update_developer_info(dev)
    dev.github_user.contrib_data = get_contrib_graph(dev.username)
  end

  def owner?(team)
    current_user == team.user && current_user != nil
  end
end
