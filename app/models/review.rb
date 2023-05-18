class Review < ApplicationRecord
  extend Mobility

  translates :comment , type: :string

  belongs_to :reviewable, polymorphic: true , required: true
  belongs_to :reviewer, polymorphic: true , required: true

  validates :rate , presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :comment , presence: true
  validates :reviewable_type, :reviewable_id, :reviewer_type, :reviewer_id , presence: true

  validate :validate_user_borrowed_book, if: -> {self.reviewer_type == "User" && self.reviewable_type == "Book"}

  def validate_user_borrowed_book
    borrow_request = self.reviewer.borrow_requests.find_by(book_id: self.reviewable_id, returned: true)
    errors.add(:base, :you_can_only_add_review ) unless borrow_request.present?
  end
end
