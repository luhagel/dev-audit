class AddIsPublicToTeam < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :is_public, :boolean
  end
end
