class AddGitGraphHtmlToDeveloper < ActiveRecord::Migration[5.0]
  def change
    add_column :developers, :git_graph_html, :text
  end
end
