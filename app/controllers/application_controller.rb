class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    before_action :set_locale


    private

    def set_locale
        locale = request.headers["Accept-Language"].to_s.downcase
        locale = locale.split('-')[0]
        available_locales = I18n.available_locales.map(&:to_s)
      
        if locale.present?
          locale = locale if available_locales.include?(locale)
        end
      
        I18n.locale = locale || I18n.default_locale
    end
      
end
