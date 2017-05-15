class AddGroupsToTeam < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :groups, :string, array: true, :default => []
  end
end
