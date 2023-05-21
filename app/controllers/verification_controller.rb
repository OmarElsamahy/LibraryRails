class VerificationController < ApplicationController
    before_action :token_verify

    def token_verify
        token = request.headers["Verification-Token"].to_s
        decoded = JwtToken.jwt_decode(token)
        payload = decoded[:payload]
        @current_user = User.find_by(email: payload[:email])
    end
end