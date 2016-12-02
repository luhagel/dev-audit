module DevelopersHelper
  def getContribGraph(username)
    doc = Nokogiri::HTML(open("https://www.github.com/" + username))
    graph = doc.css('.js-calendar-graph')
    graph.css('text').remove
    graph.css('g').first.attributes['transform'].value = 'translate(0, 0)'
    #scale rects down
    graph.css('rect').each do |r|
      r.attributes['width'].value = '6'
      r.attributes['height'].value = '6'
      r.attributes['y'].value = String(Integer(r.attributes['y'].value) / 12 * 8)   
    end
    #normalize distance between rects
    x_offset = 0
    graph.css('g>g').each do |g|
      g.attributes['transform'].value = 'translate(' + String(x_offset) + ', 0)'
      x_offset += 8
    end

    #decrease blocked space
    graph.css('svg').first.attributes['height'].value = '56'
    graph.css('svg').first.attributes['width'].value = '484'
    graph
  end

end
