require 'rails_helper'

describe 'Forecast API' do
  it 'gets the lat/long from the city/state requested' do
    get '/api/v1/forecast?location=denver,co'
    
    forecast_data = JSON.parse(response.body, symbolize_names: true)
    denver_lat = '39.7392358'
    denver_long = '-104.990251'
    expect(response).to be_successful
    expect(forecast_data[:data][:attributes][:city]).to eq('Denver')
    expect(forecast_data[:data][:attributes][:state]).to eq('CO')
    expect(forecast_data[:data][:attributes][:latitude]).to eq(denver_lat)
    expect(forecast_data[:data][:attributes][:longitude]).to eq(denver_long)
  end
  
  it 'returns weather data' do
    get '/api/v1/forecast?location=denver,co'
    
    date = Time.now.strftime('%Y-%m-%d')
    expect(response).to be_successful
    forecast_data = JSON.parse(response.body, symbolize_names: true)

    expect(forecast_data[:data][:attributes][:date]).to eq(date)
    expect(forecast_data[:data]).to have_key(:current_weather_day)  
    expect(forecast_data[:data]).to have_key(:weather_day)  
    expect(forecast_data.count).to eq(5)
  end
end