class CreateBorrowRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :borrow_requests do |t|
      t.boolean :status
      t.datetime :issue_date
      t.date :return_due_date
      t.date :borrow_start_date
      t.date :return_date
      t.boolean :returned

      t.timestamps
    end
  end
end
