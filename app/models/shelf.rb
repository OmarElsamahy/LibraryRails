class Shelf < ApplicationRecord

    extend Mobility

    translates :location , type: :string

    has_many :books
    validates :location, presence: true
end
