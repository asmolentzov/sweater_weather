class Api::V1::GifsController < ApplicationController
  
  def index
    render json: GifPresenterSerializer.new(GifPresenter.new(params[:location]))
  end
end