class VerificationController < ApplicationController
    # before_action :token_verify
    # before_action :create_payload


    def token_verify
        token = request.headers["Verification-Token"].to_s
        decoded = JwtToken.jwt_decode(token)
        payload = decoded[:payload]
        @current_user = User.find_by(email: payload[:email])
    end

    def create_payload
        @current_user = User.find_by(reset_password_token: params[:otp])
        payload = {}
        payload[:otp] = @current_user.reset_password_token
        payload[:email] = @current_user.email
        payload[:id] = @current_user.id
        @token = JwtToken.jwt_encode(payload: payload)
    end
end