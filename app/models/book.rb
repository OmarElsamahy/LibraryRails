class Book < ApplicationRecord

    extend Mobility

    translates :name , type: :string
    translates :author , type: :string

    has_many :reviews, as: :reviewable , dependent: :destroy
    belongs_to :shelf
    has_many :book_categories
    has_many :categories, through: :book_categories , dependent: :destroy
    has_many :borrow_requests
    has_many :users, through: :borrow_requests  , dependent: :destroy

    validates :name , presence: true
    validates :release_date , presence: true
    validates :author , presence: true
    validate :release_date_before_current_date
    validates_presence_of :shelf


  def release_date_before_current_date
    return unless release_date && release_date >= Date.current

    errors.add(:base, :release_date)
  end

end
