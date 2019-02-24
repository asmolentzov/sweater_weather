require 'rails_helper'

describe 'Forecast API' do
  it 'gets the lat/long from the city/state requested', :vcr do
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
  
  it 'returns weather data for current weather', :vcr do
    get '/api/v1/forecast?location=denver,co'
    
    date = Time.now.strftime('%Y-%m-%d')
    expect(response).to be_successful
    forecast_data = JSON.parse(response.body, symbolize_names: true)

    expect(forecast_data[:data][:attributes][:date]).to eq(date)
    expect(forecast_data[:data][:attributes]).to have_key(:current_weather)
    expect(forecast_data[:data][:attributes][:current_weather]).to have_key(:temperature)
    expect(forecast_data[:data][:attributes][:current_weather]).to have_key(:temp_feels_like)
    expect(forecast_data[:data][:attributes][:current_weather]).to have_key(:temp_high)
    expect(forecast_data[:data][:attributes][:current_weather]).to have_key(:temp_low)
    expect(forecast_data[:data][:attributes][:current_weather]).to have_key(:humidity)
    expect(forecast_data[:data][:attributes][:current_weather]).to have_key(:visibility)
    expect(forecast_data[:data][:attributes][:current_weather]).to have_key(:uv_index)
    expect(forecast_data[:data][:attributes][:current_weather]).to have_key(:summary)
    expect(forecast_data[:data][:attributes][:current_weather]).to have_key(:summary_short)
    expect(forecast_data[:data][:attributes][:current_weather]).to have_key(:summary_tonight)
  end
  
  it 'returns weather data for weather hours', :vcr do
    get '/api/v1/forecast?location=denver,co'
    forecast_data = JSON.parse(response.body, symbolize_names: true)
    
    expect(forecast_data[:data][:attributes]).to have_key(:weather_hours)
    expect(forecast_data[:data][:attributes][:weather_hours]).to be_a(Array)
    expect(forecast_data[:data][:attributes][:weather_hours]).to eq(8)
    expect(forecast_data[:data][:attributes][:weather_hours]).to have_key(:time)
    expect(forecast_data[:data][:attributes][:weather_hours]).to have_key(:temperature)
    expect(forecast_data[:data][:attributes][:weather_hours]).to have_key(:icon)
  end
  
  it 'returns weather data for weather days', :vcr do
    get '/api/v1/forecast?location=denver,co'
    forecast_data = JSON.parse(response.body, symbolize_names: true)
    
    expect(forecast_data[:data][:attributes]).to have_key(:weather_days)
    expect(forecast_data[:data][:attributes][:weather_days]).to be_a(Array)
    expect(forecast_data[:data][:attributes][:weather_days].count).to eq(5) 
    expect(forecast_data[:data][:attributes][:weather_days].first[:date]).to eq(Time.now.strftime('%Y-%m-%d')) 
    expect(forecast_data[:data][:attributes][:weather_days].first).to have_key(:summary)
    expect(forecast_data[:data][:attributes][:weather_days].first).to have_key(:precip_probability)
    expect(forecast_data[:data][:attributes][:weather_days].first).to have_key(:precip_type)
    expect(forecast_data[:data][:attributes][:weather_days].first).to have_key(:temp_high)
    expect(forecast_data[:data][:attributes][:weather_days].first).to have_key(:temp_low)
  end
end