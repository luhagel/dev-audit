class AddColumnsToMembership < ActiveRecord::Migration[5.0]
  def change
    add_column :memberships, :developer_id, :integer
    add_column :memberships, :team_id, :integer
  end
end
