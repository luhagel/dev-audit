class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.references :developers, foreign_key: true

      t.timestamps
    end
  end
end
