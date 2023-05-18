class AuthenticationController < ApplicationController
    
    # skip_before_action :authenticate_user

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
      @otp = 6.times.map{rand(10)}.join.to_s
      dupe=true
      while dupe
        user = User.where(reset_password_token: @otp).first
        if user
          @otp = 6.times.map{rand(10)}.join.to_s
        else
          dupe = false
        end
      end
      user = User.find_by_email(params[:email])
      ActiveRecord::Base.transaction do
        begin
          user.reset_password_token = @otp
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
      token = request.headers["Verification-Token"].to_s
      decoded = JwtToken.jwt_decode(token)
      payload = decoded[:payload]
      user = User.find_by_email(payload[:email])
      if user 
        if params[:password] == params[:password_confirmation]
          ActiveRecord::Base.transaction do
            begin
              user.password = params[:password]

              user.reset_password_token = ""

              user.save!

              render json: UserSerializer.new(user).serializable_hash.to_json
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
