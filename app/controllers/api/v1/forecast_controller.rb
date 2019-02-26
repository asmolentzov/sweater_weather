class Api::V1::ForecastController < ApplicationController
  def index
    forecast = Forecast.new(location: params[:location])
    render json: ForecastSerializer.new(forecast)
  end
end