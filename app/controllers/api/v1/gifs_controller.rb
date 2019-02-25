class Api::V1::GifsController < ApplicationController
  
  def index
    gifs = GifPresenter.new(params[:location])
    render json: GifPresenterSerializer.new(gifs)
  end
end