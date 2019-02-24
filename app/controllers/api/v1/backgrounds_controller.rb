class Api::V1::BackgroundsController < ApplicationController
  def index
    background = Background.new(params[:location])
    render json: 'hi'
  end
end