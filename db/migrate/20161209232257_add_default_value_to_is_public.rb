class AddDefaultValueToIsPublic < ActiveRecord::Migration[5.0]
  def change
    change_column :teams, :is_public, :boolean, :default => false
  end
end
