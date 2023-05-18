class EditColumnInBorrowRequest < ActiveRecord::Migration[7.0]
  def change
    change_column :borrow_requests, :returned, :boolean, :default => false
  end
end
