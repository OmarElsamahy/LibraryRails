ActiveAdmin.register Category do

  searchable_select_options(scope: Category.all,
    text_attribute: :name,
    filter: lambda do |term, scope|
      scope.ransack(name_cont: term).result
    end)

    form do |f|
      f.inputs "Category Details" do
        I18n.available_locales.each do |locale|
          f.input "name_#{locale}".to_sym, label: "#{locale.to_s.capitalize} Name"
        end

      end
      f.actions
    end

    show do
        attributes_table do
          row :name do |category|
            I18n.available_locales.map do |locale|
              "#{locale.to_s.capitalize} Name: #{category.send("name_#{locale.to_s}")}"
            end.join("<br>").html_safe
          end
        end
      end

  permit_params do
    I18n.available_locales.map { |locale| "name_#{locale}".to_sym }
  end
end