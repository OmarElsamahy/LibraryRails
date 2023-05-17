class Shelf < ApplicationRecord
    has_many :books
    validates :location, presence: true
end
