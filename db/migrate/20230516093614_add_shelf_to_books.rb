class AddShelfToBooks < ActiveRecord::Migration[7.0]
  def change
    add_reference :books, :shelf, null: false, foreign_key: true
  end
end
