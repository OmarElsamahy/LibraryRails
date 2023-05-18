class Category < ApplicationRecord
    extend Mobility

    translates :name , type: :string

    has_and_belongs_to_many :books
    
    validates :name , presence: true
  end
  