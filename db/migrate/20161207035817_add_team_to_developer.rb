class AddTeamToDeveloper < ActiveRecord::Migration[5.0]
  def change
    add_reference :developers, :team, foreign_key: true
  end
end
