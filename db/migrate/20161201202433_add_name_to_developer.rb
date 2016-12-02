class AddNameToDeveloper < ActiveRecord::Migration[5.0]
  def change
    add_column :developers, :name, :string
  end
end
