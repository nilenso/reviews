class AddLevelOnlyStatusToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :is_level_only, :boolean, default: false
  end
end
