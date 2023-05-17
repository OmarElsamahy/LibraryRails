class Library < ApplicationRecord
    has_many :reviews, as: :reviewable

    validates :name , presence: true
    validates :address , presence: true
end
