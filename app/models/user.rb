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
      user = User.where(reset_password_token: @otp).first
      if user
        @otp = 6.times.map{rand(10)}.join.to_s
      else
        dupe = false
        user.reset_password_token = @otp
      end
    end
  end
end
