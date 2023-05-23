class Library < ApplicationRecord

    extend Mobility

    translates :name , type: :string
    translates :address , type: :string
    has_many :reviews, as: :reviewable

    validates :name , presence: true
    validates :address , presence: true
end
