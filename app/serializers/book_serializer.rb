class BookSerializer < BaseSerializer
  attributes :name,:author , :release_date ,:category_count
  
  attribute :category_count do |object|
    object.with_category_count
  end
end
