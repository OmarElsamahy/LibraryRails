ActiveAdmin.register Category do
    form do |f|
        f.inputs "Category Details" do
          I18n.available_locales.each do |locale|
            f.input ("name_#{locale.to_s}".to_s) , label: "#{locale.to_s} Name"
          end
        end
        f.actions
      end
end