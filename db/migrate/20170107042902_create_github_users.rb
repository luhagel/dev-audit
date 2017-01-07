class CreateGithubUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :github_users do |t|
      t.string :login
      t.integer :user_id
      t.string :name, default: ""
      t.string :company, default: ""
      t.string :blog, default: ""
      t.string :location, default: ""
      t.string :email, default: ""
      t.boolean :hireable, default: false
      t.string :bio, default: ""
      t.integer :public_repos, default: 0
      t.integer :public_gists, default: 0
      t.integer :followers, default: 0
      t.integer :following, default: 0
      t.integer :contributions, array: true, default: []

      t.timestamps
    end
  end
end
