class AddLevelOnlyStatusToReviews < ActiveRecord::Migration[4.2]
  def change
    add_column :reviews, :is_level_only, :boolean, default: false
  end
end
