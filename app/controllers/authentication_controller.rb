class AuthenticationController < ApplicationController
    
    skip_before_action :authenticate_user
    def login
        @user = User.find_by_email(params[:email])
        if @user.valid_password?(params[:password])
          token = JwtToken.jwt_encode(user_id: @user.id)
          time = Time.now + 24.hours.to_i
          render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M") }, status: :ok
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
      end
    
      private
    
      def login_params
        params.permit(:email, :password)
      end
end
