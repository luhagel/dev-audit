class AddDeveloperToGithubUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :github_users, :developer, foreign_key: true
  end
end
