class RemoveUnneededDeveloperColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :developers, :git_graph_html, :text
  end
end
