class Api::V1::SessionsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate
  
  def create
      render json: { api_key: user.api_key }
  end
  
  private
  
  def authenticate
    unless user && user.try(:authenticate, params[:password])
      render json: {}, status: :unauthorized
    end
  end
  
  def user
    @user ||= User.find_by(email: params[:email])
  end
end