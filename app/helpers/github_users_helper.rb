module GithubUsersHelper
  def get_contrib_data(username)
    doc = Nokogiri::HTML(open('https://www.github.com/users/' + username + '/contributions'))
    graph = doc.css('.js-calendar-graph-svg')
    graph_array = []
    graph.css('rect').each do |r|
      graph_array += [r.attributes['data-count'].value]
    end
    graph_array
  end

  def update_all_developer_info
    @github_users = GithubUser.all
    save_counter = 0
    @github_users.each do |u|
      puts u.login
      u.contributions = get_contrib_data(u.login)
      save_counter += 1 if u.save
    end
    puts 'SUCCESS: Updated ' + String(save_counter) + '/' + String(@github_users.count) + ' Developers!'
  end
end
