class DropColumnFromBorrowRequest < ActiveRecord::Migration[7.0]
  def change
    remove_column :borrow_requests, :return_date, :date
    remove_column :borrow_requests, :borrow_start_date, :date
  end
end
