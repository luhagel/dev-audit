class ChangeTeamGroupsToText < ActiveRecord::Migration[5.1]
  def change
    change_column :teams, :groups, :text
  end
end
