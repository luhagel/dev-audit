module DevelopersHelper
  include ActionView::Helpers::OutputSafetyHelper

  def generate_graph_svg(graph_array)
    svg = '<svg xmlns="http://www.w3.org/2000/svg" viewbox="0 0 ' + String(graph_array.count) + ' 60">'
    svg += '<line x1="0" x2="' + String(graph_array.count) + '" y1="30" y2="30" stroke-width="1" stroke="black"/>'
    line_offset = 0
    graph_array.each do |line|
      svg += '<line x1="' + String(line_offset) + '" x2="' + String(line_offset) + '" y1="' + String(30 - line.to_i * 1.5 ) + '" y2="' + String(30 + line.to_i * 1.5) + '" stroke-width="1"  class="graph-line" />'
      line_offset += 1
    end
    svg += '</svg>'
    svg
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
