class Book < ApplicationRecord
    has_many :reviews, as: :reviewable
    belongs_to :shelf
    # has_and_belongs_to_many :categories
    has_many :book_categories
    has_many :categories, through: :book_categories
    has_many :borrow_requests
    has_many :users, through: :borrow_requests  

    validates :name , presence: true
    validates :release_date , presence: true
    validates :author , presence: true
end
