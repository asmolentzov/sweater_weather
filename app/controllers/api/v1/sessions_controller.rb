class Api::V1::SessionsController < ApplicationController
  protect_from_forgery with: :null_session
  
  def create
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    render json: { api_key: user.api_key }
  end
end