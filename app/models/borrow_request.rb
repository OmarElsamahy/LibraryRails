class BorrowRequest < ApplicationRecord
    belongs_to :user
    belongs_to :book

    after_create_commit :schedule_return_check

    enum status: { pending: 'pending', accepted: 'accepted', denied: 'denied' , returned: 'returned'}

    validates :issue_date , presence: true
    validates :return_due_date , presence: true
    validates :user_id, presence: true
    validates :book_id , presence: true
    validate :validate_unique_accepted_request, on: :create

    scope :successfully_accepted, -> { where(status: 'accepted') }


    def validate_unique_accepted_request
      existing_request = BorrowRequest.find_by(book_id: self.book_id, user_id: self.user_id ,status: 'accepted').present?
      errors.add(:base, :owned_by_other_user) if existing_request
    end

    def schedule_return_check
      BorrowRequestWorker.perform_at(self.return_due_date.to_datetime, self.id)
    end
    

end
