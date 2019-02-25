class Api::V1::FavoritesController < ApplicationController
  before_action :require_authorization
  def create
    
  end
  
  private
  
  def require_authorization
    unless authorized
      render json: {}, status: :unauthorized 
    end
  end
  
  def authorized
    params[:api_key] && User.find_by(api_key: params[:api_key])
  end
end