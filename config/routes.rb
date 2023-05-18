Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # devise_for :users

  scope :users do
    resources :borrow_requests
  end
  resources :books
  resources :reviews
  resources :shelves
  resources :book_categories
  resources :categories
  post '/auth/login' ,to: 'authentication#login'
  post '/auth/send_otp' ,to: 'authentication#send_otp'
  post '/auth/verify_otp' ,to: 'authentication#verify_otp'
  post '/auth/reset_password' ,to: 'authentication#reset_password'

end
