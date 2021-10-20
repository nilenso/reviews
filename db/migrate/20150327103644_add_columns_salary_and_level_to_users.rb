class AddColumnsSalaryAndLevelToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :salary, :decimal, scale: 2, precision: 100
    add_column :users, :level, :decimal, scale: 2, precision: 100
  end
end
