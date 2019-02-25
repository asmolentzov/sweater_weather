class Api::V1::GifsController < ApplicationController
  
  def index
    gifs = GifPresenter.new(location: params[:location])
    render json: GifPresenterSerializer.new(gifs)
  end
end