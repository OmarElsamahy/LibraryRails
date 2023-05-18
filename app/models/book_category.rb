class BookCategory < ApplicationRecord


    belongs_to :book
    belongs_to :category

    validates_uniqueness_of :book_id, scope: :category_id
    validate :validate_categories_count

    def validate_categories_count
        if self.class.where(book_id: self.book_id).count >= 2
            errors.add(:categories, "can't exceed three")
        end
    end
end