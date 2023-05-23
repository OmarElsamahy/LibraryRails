class AddStatusToBorrowRequests < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE TYPE borrow_request_status AS ENUM ('pending', 'accepted', 'denied');
    SQL
    add_column :borrow_requests, :status, :borrow_request_status, default: 'pending'
  end

  def down
    remove_column :borrow_requests, :status
    execute <<-SQL
      DROP TYPE borrow_request_status;
    SQL
  end
end
