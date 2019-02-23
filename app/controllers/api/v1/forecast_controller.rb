class Api::V1::ForecastController < ApplicationController
  def index
    forecast = Forecast.new(params[:location])
    render json: ForecastSerializer.new(forecast)
  end
  
  private
  
  # def forecast_params
  #   location = params[:location].split(',')
  #   { city: location[0].capitalize, state: location[1].upcase }
  # end
end