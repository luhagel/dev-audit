# Github Users helper
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

  def get_prefered_languages(username)
    doc = Nokogiri::HTML(open('https://www.github.com/' + username))
    pinned = doc.css('.pinned-repos-list')
    languages_array = []
    pinned.css('.pinned-repo-item').each do |repo|
      lang = repo.css('p.mb-0').children[2]
      if lang
        lang = lang.text.strip
        if lang != ''
          languages_array += [lang]
        end
      end
    end
    languages_array.to_set
  end

  def update_all_developer_info
    @github_users = GithubUser.all
    save_counter = 0
    @github_users.each do |u|
      puts u.login
      u.pull_github_data
      u.contributions = get_contrib_data(u.login)
      u.prefered_languages = get_prefered_languages(u.login).to_a
      if u.save
        save_counter += 1 if u.save
      else
        puts 'FAIL'
      end
    end
    puts 'SUCCESS: Updated ' + String(save_counter)
  end
end
