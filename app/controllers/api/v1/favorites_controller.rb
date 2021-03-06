class Api::V1::FavoritesController < ApplicationController
  protect_from_forgery with: :null_session
  
  before_action :require_authorization
  
  def index
    render json: FavoriteSerializer.new(current_user.favorites)
  end
  
  def create
    current_user.favorites.create(location: location)
    render json: FavoriteSerializer.new(Favorite.last), status: :created
  end
  
  def destroy
    favorite.destroy
    render json: FavoriteSerializer.new(favorite)
  end
  
  private
  
  def current_user
    User.find_by(api_key: params[:api_key])
  end
  
  def location
    @_location ||= Location.find(params[:location])
  end
  
  def favorite
    @_favorite ||= Favorite.find_by(location: params[:location])
  end
  
  def require_authorization
    unless authorized
      render json: {}, status: :unauthorized 
    end
  end
  
  def authorized
    params[:api_key] && current_user
  end
end