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
end
