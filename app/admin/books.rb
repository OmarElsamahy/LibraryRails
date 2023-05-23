# app/admin/books.rb
ActiveAdmin.register Book do

    permit_params do
      permitted =  [:release_date, :shelf_id, category_ids: []]
      permitted << I18n.available_locales.map {|locale| "name_#{locale.to_s}".to_sym}
      permitted << I18n.available_locales.map {|locale| "author_#{locale.to_s}".to_sym}
      permitted
    end

    form do |f|
      f.inputs "Book Details" do
        I18n.available_locales.each do |locale|
          f.input ("name_#{locale.to_s}".to_s) , label: "#{locale.to_s} Name"
        end
        # f.input :author
        I18n.available_locales.each do |locale|
          f.input ("author_#{locale.to_s}".to_s) , label: "#{locale.to_s} Author"
      end
      f.input :release_date
      f.input :shelf

      f.input :categories, as: :searchable_select, ajax: true
    end
    f.actions
    end

    show do
      attributes_table do
        I18n.available_locales.each do |locale|
          row ("name_#{locale.to_s}".to_s) , label: "#{locale.to_s} Name"
        end
        I18n.available_locales.each do |locale|
          row ("author_#{locale.to_s}".to_s) , label: "#{locale.to_s} Author"
        end
        row :release_date
        row :shelf_id
        row :categories
      end
      active_admin_comments
    end
  end
  