class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  include JwtToken

#    before_action :authenticate_user

    # before_action :set_locale
    private
        def authenticate_user
            header = request.headers['Authorization']
            header = header.split(' ').last if header
            begin
            @decoded = JwtToken.jwt_decode(header)
            @current_user = User.find(@decoded[:user_id])
            rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
            rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
            end
        end

        def set_locale
            I18n.locale = extract_locale_from_url || I18n.default_locale
        end

        def extract_locale_from_url
            parsed_locale = params[:locale]&.to_sym
            I18n.available_locales.include?(parsed_locale) ? parsed_locale : nil
          end

end
