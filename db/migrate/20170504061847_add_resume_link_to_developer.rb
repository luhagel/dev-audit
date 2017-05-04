class AddResumeLinkToDeveloper < ActiveRecord::Migration[5.1]
  def change
    add_column :developers, :resume_link, :string
  end
end
