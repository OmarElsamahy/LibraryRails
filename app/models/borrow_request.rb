class BorrowRequest < ApplicationRecord
    belongs_to :user
    belongs_to :book

    validates :issue_date , presence: true
    validates :return_due_date , presence: true
    validates :borrow_start_date , presence: true
    validates :return_date , presence: true

    validate :validate_unique_accepted_request

    scope :successfully_accepted, -> { where(status: 'accepted') }

  private

  def validate_unique_accepted_request
    existing_request = BorrowRequest.find_by(book_id: self.book_id, status: 'accepted' , returned: false)
    if existing_request
      errors.add(:base, :owned_by_other_user)
    end
  end
end
