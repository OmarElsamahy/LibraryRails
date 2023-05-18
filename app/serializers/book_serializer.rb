class BookSerializer < BaseSerializer      
  attributes :name , :author ,:release_date

  def name
    object.name
  end
  def author
    object.author
  end
end