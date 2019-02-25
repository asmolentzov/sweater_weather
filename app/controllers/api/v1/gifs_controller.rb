class Api::V1::GifsController < ApplicationController
  
  def index
    gifs = WeatherGif.new(location: params[:location])
    render json: WeatherGifSerializer.new(gifs)
  end
end