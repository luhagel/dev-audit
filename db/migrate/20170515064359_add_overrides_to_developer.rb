class AddOverridesToDeveloper < ActiveRecord::Migration[5.1]
  def change
    add_column :developers, :email, :string
  end
end
