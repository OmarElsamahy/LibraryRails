# app/admin/books.rb
ActiveAdmin.register Book do
    permit_params :name, :author, :release_date, :shelf_id, category_ids: []
  
    form do |f|
      f.inputs "Book Details" do
        f.input :name
        f.input :author
        f.input :release_date
        f.input :shelf
        f.input :categories, as: :check_boxes, collection: Category.all
      end
      f.actions
    end
  end
  