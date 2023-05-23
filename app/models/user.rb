class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :borrow_requests
  has_many :books, through: :borrow_requests
  has_many :reviews, as: :reviewer


  def set_otp
    @otp = 6.times.map{rand(10)}.join.to_s
    dupe=true
    while dupe
      userOTP = User.where(reset_password_token: @otp).first.present?
      if userOTP
        @otp = 6.times.map{rand(10)}.join.to_s
      else
        dupe = false
        self.reset_password_token = @otp
      end
    end
  end
end
