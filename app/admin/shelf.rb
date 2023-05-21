ActiveAdmin.register Shelf do
    form do |f|
      f.inputs "Shelf Details" do
        I18n.available_locales.each do |locale|
          f.input "location_#{locale}".to_sym, label: "#{locale.to_s.capitalize} Location"
        end
      end
      f.actions
    end

    show do
        attributes_table do
          row :location do |category|
            I18n.available_locales.map do |locale|
              "#{locale.to_s.capitalize} Location: #{shelf.send("location_#{locale.to_s}")}"
            end.join("<br>").html_safe
          end
        end
      end

  permit_params do
    I18n.available_locales.map { |locale| "location_#{locale}".to_sym }
  end
end