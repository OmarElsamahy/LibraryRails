class BorrowRequestWorker
    include Sidekiq::Worker
  
    def perform(borrow_request_id)
      borrow_request = BorrowRequest.find(borrow_request_id)
      return if borrow_request.returned?
  
      if borrow_request.return_due_date.past?
        puts "User #{borrow_request.user_id} has not returned the book #{borrow_request.book_id} for borrow request #{borrow_request_id}"
      end
    end
  end