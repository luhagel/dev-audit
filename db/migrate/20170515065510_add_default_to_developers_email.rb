class AddDefaultToDevelopersEmail < ActiveRecord::Migration[5.1]
  def change
    change_column :developers, :email, :string, default: 'N/A'
  end
end
