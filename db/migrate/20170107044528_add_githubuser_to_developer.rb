class AddGithubuserToDeveloper < ActiveRecord::Migration[5.0]
  def change
    add_reference :developers, :github_user, foreign_key: true
  end
end
