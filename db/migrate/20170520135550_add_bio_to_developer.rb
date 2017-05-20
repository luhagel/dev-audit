class AddBioToDeveloper < ActiveRecord::Migration[5.1]
  def change
    add_column :developers, :bio, :text
  end
end
