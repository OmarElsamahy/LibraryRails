class RemoveStatusFromBorrowRequests < ActiveRecord::Migration[7.0]
  def change
    remove_column :borrow_requests, :status, :boolean
  end
end
