class AddUsernamesToDeveloper < ActiveRecord::Migration[5.0]
  def change
    add_column :developers, :medium_username, :string, :default => ""
    add_column :developers, :twitter_username, :string, :default => ""
  end
end
