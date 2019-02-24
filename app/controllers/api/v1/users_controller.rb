class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session
  
  def create
    user = User.new(user_params)
    user.save
    render json: { api_key: user.api_key }, status: :created
  end
  
  private
  
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end