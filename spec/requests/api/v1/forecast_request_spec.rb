require 'rails_helper'

describe 'Forecast API' do
  it 'gets the lat/long from the city/state requested' do
    get '/api/v1/forecast?location=denver,co'
    
    forecast = Forecast.last
    
    expect(response).to be_successful
    expect(forecast.city).to eq('Denver')
    expect(forecast.state).to eq('CO')
    expect(forecast.latitude).to eq('39.7392358')
    expect(forecast.longitude).to eq('-104.990251')
  end
  
  it 'returns weather data' do
    get '/api/v1/forecast?location=denver,co'
    
    forecast = Forecast.last
    date = Time.now.strftime('%Y-%m-%d')
    expect(response).to be_successful
    forecast_data = JSON.parse(response.body, symbolize_names: true)
    expect(forecast_data[:data][:attributes][:latitude]).to eq(forecast.latitude)
    expect(forecast_data[:data][:attributes][:longitude]).to eq(forecast.longitude)
    expect(forecast_data[:data][:attributes][:city]).to eq(forecast.city)
    expect(forecast_data[:data][:attributes][:state]).to eq(forecast.state)
    expect(forecast_data[:data][:attributes][:date]).to eq(date)
    expect(forecast_data[:data]).to have_key(:current_weather_day, count: 1)  
    expect(forecast_data[:data]).to have_key(:weather_day, count: 5)  
    expect(forecast_data.count).to eq(5)
  end
end