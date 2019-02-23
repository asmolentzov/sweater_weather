class Api::V1::ForecastController < ApplicationController
  def index
    forecast = Forecast.create(forecast_params)
    render json: 'hi'
  end
  
  private
  
  def forecast_params
    location = params[:location].split(',')
    { city: location[0].capitalize, state: location[1].upcase }
  end
end