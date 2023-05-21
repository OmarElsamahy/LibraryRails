class BorrowRequest < ApplicationRecord
    belongs_to :user
    belongs_to :book

    enum status: { pending: 'pending', accepted: 'accepted', denied: 'denied' }

    validates :issue_date , presence: true
    validates :return_due_date , presence: true
    validates :user_id, presence: true
    validates :book_id , presence: true
    validate :validate_unique_accepted_request

    scope :successfully_accepted, -> { where(status: 'accepted') }

  private

  def validate_unique_accepted_request
    existing_request = BorrowRequest.find_by(book_id: self.book_id, user_id: self.user_id ,status: 'accepted' , returned: false).present?
    errors.add(:base, :owned_by_other_user) if existing_request
  end
  
end
