class RemoveTeamidFromDeveloper < ActiveRecord::Migration[5.0]
  def change
    remove_column :developers, :team_id, :integer
  end
end
