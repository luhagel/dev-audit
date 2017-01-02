module DevelopersHelper
  include ActionView::Helpers::OutputSafetyHelper

  def get_contrib_graph(username)
    doc = Nokogiri::HTML(open('https://www.github.com/users/' + username + '/contributions'))
    graph = doc.css('.js-calendar-graph-svg')
    graph_array = []
    graph.css('text').remove
    graph.css('rect').each do |r|
      graph_array += [r.attributes['data-count'].value]
    end
    generate_graph_svg(graph_array)
  end

  def generate_graph_svg(graph_array)
    svg = '<svg xmlns="http://www.w3.org/2000/svg" viewbox="0 0 360 40">'
    svg += '<line x1="0" x2="360" y1="20" y2="20" stroke-width="2" stroke="black" />'
    line_offset = 0
    graph_array.each do |line|
      svg += '<line x1="' + String(line_offset) + '" x2="' + String(line_offset) + '" y1="' + String(20 - line.to_i * 1.5 ) + '" y2="' + String(20 + line.to_i * 1.5) + '" stroke-width="1" stroke="purple" />'
      line_offset += 1
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
      dev.git_graph_html = get_contrib_graph(dev.username)
      save_counter += 1 if dev.save
    end
    puts 'SUCCESS: Updated ' + String(save_counter) + '/' + String(@developers.count) + ' Developers!'
  end

  def update_developer_info(dev)
    dev.git_graph_html = get_contrib_graph(dev.username)
  end
end
