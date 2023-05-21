class BookSerializer < BaseSerializer      
  attributes :name , :author ,:release_date
  
  attribute :author do |record|
    record.author
  end
  attribute :name do |record|
    record.name
  end
end