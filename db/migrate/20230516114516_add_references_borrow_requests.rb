class AddReferencesBorrowRequests < ActiveRecord::Migration[7.0]
  def change
    add_reference :borrow_requests, :user, foreign_key: true , index: true
    add_reference :borrow_requests, :book, foreign_key: true , index: true
  end
end
