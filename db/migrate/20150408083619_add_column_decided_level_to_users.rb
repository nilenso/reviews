class AddColumnDecidedLevelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :decided_level, :decimal, scale: 2, precision: 100
  end
end
