class CreateReviews < ActiveRecord::Migration[4.2]
  def change
    create_table :reviews do |t|
      t.integer :status, default: 0
      t.references :reviewer, index: true
      t.references :reviewee, index: true
      t.text :text

      t.timestamps null: false
    end

    add_foreign_key :reviews, :users, column: :reviewer_id
    add_foreign_key :reviews, :users, column: :reviewee_id
  end
end
