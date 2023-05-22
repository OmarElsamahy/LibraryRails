class DropColumnInBorrowRequests < ActiveRecord::Migration[7.0]
  def change
    remove_column :borrow_requests, :returned
  end
end
