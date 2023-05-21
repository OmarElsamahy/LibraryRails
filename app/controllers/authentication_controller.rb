class AuthenticationController < VerificationController
    
    # skip_before_action :authenticate_user

    before_action :token_verify , only: [:reset_password]

    def login
        @user = User.find_by_email(params[:email])
        if @user.valid_password?(params[:password])
          token = JwtToken.jwt_encode(user_id: @user.id)
          time = Time.now + 24.hours.to_i
          render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M") }, status: :ok
        else
          render json: { errors: 'unauthorized' }, status: :unauthorized
        end
    end

    def send_otp
      user = User.find_by(email: params[:email])
      user.set_otp
      ActiveRecord::Base.transaction do
        begin
          user.save!
        rescue => exception
          render json: {errors: exception}
        end
      end
      # should send email with otp in it but for no i will render it
      render json: {otp: @otp} 
    end

    def verify_otp
      user = User.find_by(reset_password_token: params[:otp])
      if user
        payload = {}
        payload[:otp] = user.reset_password_token
        payload[:email] = user.email
        payload[:id] = user.id
        token = JwtToken.jwt_encode(payload: payload)
        render json: {'Verification Token': token}
      else
        render json: {errors: 'OTP Incorrect'}
      end
    end

    def reset_password
      if @current_user 
        if params[:password] == params[:password_confirmation]
          ActiveRecord::Base.transaction do
            begin
              @current_user.password = params[:password]

              @current_user.reset_password_token = ""

              @current_user.save!

              render json: UserSerializer.new(@current_user).serializable_hash.to_json
            rescue
              render json: {errors: "Error updating password in db"}
            end
          end
        else
          render json: {errors: "Passwords do not match"}
        end
      else 
        render json: {errors: "User Not Found"}
      end
    end


    private
  
    def login_params
      params.permit(:email, :password)
    end

end
