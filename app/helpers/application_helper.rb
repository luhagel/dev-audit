module ApplicationHelper
  def active?(link_path)
    current_page?(link_path) ? 'is-active' : ''
  end
end
