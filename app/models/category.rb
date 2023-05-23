class Category < ApplicationRecord
    extend Mobility

    translates :name , type: :string

    has_many :book_categories
    has_many :books , through: :book_categories
    
    validates :name , presence: true
  end
  