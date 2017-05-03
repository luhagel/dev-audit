class AddPreferredLanguagesToGithubUser < ActiveRecord::Migration[5.0]
  def change
    add_column :github_users, :prefered_languages, :string, array: true, :default => []
  end
end
