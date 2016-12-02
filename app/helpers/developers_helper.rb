module DevelopersHelper
  def getContribGraph(username)
    doc = Nokogiri::HTML(open("https://www.github.com/" + username))
    graph = doc.css('.js-calendar-graph')
    graph
  end

end
