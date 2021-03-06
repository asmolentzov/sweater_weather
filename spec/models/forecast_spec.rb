require 'rails_helper'

describe Forecast do
  it 'exists and has basic attributes', :vcr do
    location = 'denver,co'
    forecast = Forecast.new(location)
    expect(forecast).to be_a(Forecast)
    expect(forecast.city).to eq('Denver')
    expect(forecast.state).to eq('CO')
  end
  it 'sets the latitude and longitude for a forecast', :vcr do
    location = 'denver,co'
    forecast = Forecast.new(location)
    expect(forecast.latitude).to eq('39.7392358')
    expect(forecast.longitude).to eq('-104.990251')
    
    hawaii_location = 'honolulu,hi'
    hawaii_forecast = Forecast.new(hawaii_location)
    expect(hawaii_forecast.latitude).to eq('21.3069444')
    expect(hawaii_forecast.longitude).to eq('-157.8583333')
  end
  it 'sets the date for a forecast', :vcr do
    location = 'denver,co'
    forecast = Forecast.new(location)
    expect(forecast.date).to eq(Time.now.strftime('%Y-%m-%d'))
  end
  it 'can get current_weather info', :vcr do
    location = 'denver,co'
    forecast = Forecast.new(location)

    weather = JSON.parse(forecast.get_current_weather.to_json, symbolize_names: true)
    expect(weather).to have_key(:temperature)
    expect(weather[:temperature]).to_not be_nil
    expect(weather).to have_key(:temp_feels_like)
    expect(weather[:temp_feels_like]).to_not be_nil
    expect(weather).to have_key(:temp_high)
    expect(weather).to have_key(:temp_low)
    expect(weather).to have_key(:humidity)
    expect(weather).to have_key(:visibility)
    expect(weather).to have_key(:uv_index)
    expect(weather).to have_key(:summary)
    expect(weather).to have_key(:summary_short)
    expect(weather).to have_key(:summary_tonight)
  end
  it 'can get weather days', :vcr do
    allow_any_instance_of(Forecast).to receive(:latitude).and_return('12')
    allow_any_instance_of(Forecast).to receive(:longitude).and_return('-12')
    forecast = Forecast.new('denver,co')

    weather_days = forecast.get_weather_days
    expect(weather_days).to be_a(Array)
    expect(weather_days.count).to eq(5)
    expect(weather_days.first).to have_key(:date)
    expect(weather_days.first).to have_key(:icon)
    expect(weather_days.first).to have_key(:summary)
    expect(weather_days.first).to have_key(:precip_probability)
    expect(weather_days.first).to have_key(:temp_high)
    expect(weather_days.first).to have_key(:temp_low)
  end
  it 'can get weather hours', :vcr do
    allow_any_instance_of(Forecast).to receive(:latitude).and_return('12')
    allow_any_instance_of(Forecast).to receive(:longitude).and_return('-12')
    forecast = Forecast.new('denver,co')
    
    weather_hours = forecast.get_weather_hours
    expect(weather_hours).to be_a(Array)
    expect(weather_hours.count).to eq(8)
    expect(weather_hours.first).to have_key(:time)
    expect(weather_hours.first).to have_key(:temperature)
    expect(weather_hours.first).to have_key(:icon)
  end
  it 'creates location record if needed', :vcr do
    location = 'denver,co'
    Forecast.new(location)
    loc = Location.last
    expect(loc.city).to eq('Denver')
    expect(loc.state).to eq('CO')
  end
  it 'finds existing location record if present', :vcr do
    location = create(:location)
    loc_string = "#{location.city},#{location.state}"
    Forecast.new(loc_string)
    expect(Location.last).to eq(location)
  end
end
