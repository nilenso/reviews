class CreateReviewYears < ActiveRecord::Migration[4.2]
  def change
    create_table :review_years do |t|
      t.text :name
      t.timestamps
    end

    add_column :reviews, :review_year_id, :integer
    add_foreign_key :reviews, :review_years, column: :review_year_id
  end
end
