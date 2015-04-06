class AddColumnSuggestedLevelToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :suggested_level, :decimal, scale: 2, precision: 100
  end
end
