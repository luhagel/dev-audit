module DevelopersHelper
  include ActionView::Helpers::OutputSafetyHelper

  def getContribGraph(username)
    doc = Nokogiri::HTML(open("https://www.github.com/" + username))
    graph = doc.css('.js-calendar-graph')
    graph.css('text').remove
    graph.css('g').first.attributes['transform'].value = 'translate(-20, 0)'
    #smaller rects
    graph.css('rect').each do |r|
      r.attributes['width'].value = '6'
      r.attributes['height'].value = '6'
      r.attributes['y'].value = String(Integer(r.attributes['y'].value) / 12 * 6)   
    end
    #remove space between rects
    x_offset = 0
    graph.css('g>g').each do |g|
      g.attributes['transform'].value = 'translate(' + String(x_offset) + ', 0)'
      x_offset += 7
    end

    #decrease blocked space
    graph.css('svg').first.attributes['height'].value = '42'
    graph.css('svg').first.attributes['width'].value = '370'
    raw(graph)
  end

end
