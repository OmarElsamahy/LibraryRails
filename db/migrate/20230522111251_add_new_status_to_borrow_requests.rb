class AddNewStatusToBorrowRequests < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
    ALTER TYPE borrow_request_status ADD VALUE 'returned';
    SQL
  end

  def down
    execute <<-SQL
    ALTER TYPE borrow_request_status DROP VALUE 'returned';
    SQL
  end  
end
