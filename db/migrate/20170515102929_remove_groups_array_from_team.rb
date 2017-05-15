class RemoveGroupsArrayFromTeam < ActiveRecord::Migration[5.1]
  def change
    change_column :teams, :groups, :string
  end
end
