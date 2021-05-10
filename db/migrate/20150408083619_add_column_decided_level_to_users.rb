class AddColumnDecidedLevelToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :decided_level, :decimal, scale: 2, precision: 100
  end
end
