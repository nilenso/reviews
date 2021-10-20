class AddColumnSuggestedLevelToReviews < ActiveRecord::Migration[4.2]
  def change
    add_column :reviews, :suggested_level, :decimal, scale: 2, precision: 100
  end
end
