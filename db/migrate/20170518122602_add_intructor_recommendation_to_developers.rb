class AddIntructorRecommendationToDevelopers < ActiveRecord::Migration[5.1]
  def change
    add_column :developers, :instructor_recommendation, :text
  end
end
