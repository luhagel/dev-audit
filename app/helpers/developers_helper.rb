module DevelopersHelper
  include ActionView::Helpers::OutputSafetyHelper

  def get_contrib_graph(username)
    doc = Nokogiri::HTML(open('https://www.github.com/' + username))
    graph = doc.css('.js-calendar-graph')
    graph_array = []
    graph.css('text').remove
    graph.css('rect').each do |r|
      graph_array += [r.attributes['data-count'].value]
    end
    graph_array
  end

  def generate_graph_svg(graph_array)
    svg = '<svg width="300px" height="300px" xmlns="http://www.w3.org/2000/svg">'
    graph_array.each do |rect|
      color = get_rect_color(rect)
      
    end
    svg += '</svg>'
    svg
  end

  def check_for_404(url)
    uri = URI(url)
    Net::HTTP.use_ssl = true
    Net::HTTP.use_.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Head.new uri.request_uri
      response = http.request request
      return response == Net::HTTPNotFound
    end
  end

  def update_all_developer_info
    @developers = Developer.all
    save_counter = 0
    @developers.each do |dev|
      dev.git_graph_html = get_contrib_graph(dev.username, 4)
      save_counter += 1 if dev.save
    end
    puts 'SUCCESS: Updated ' + String(save_counter) + '/' + String(@developers.count) + ' Developers!'
  end

  def update_developer_info(dev)
    dev.git_graph_html = get_contrib_graph(dev.username)
  end
end
