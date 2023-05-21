class AddColumnToBorrowRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :borrow_requests , :notified , :boolean
  end
end
