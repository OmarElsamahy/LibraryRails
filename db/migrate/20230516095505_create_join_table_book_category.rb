class CreateJoinTableBookCategory < ActiveRecord::Migration[7.0]
  def change
    create_table :book_categories do |t|
      t.references :book, foreign_key: true, null: false
      t.references :category, foreign_key: true, null: false
      t.index [:book_id, :category_id]
      t.index [:category_id, :book_id]
    end
  end
end
