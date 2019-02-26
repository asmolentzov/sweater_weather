require 'rails_helper'

describe Forecast do
  it 'exists and has basic attributes', :vcr do
    location = 'denver,co'
    forecast = Forecast.new(location: location)
    expect(forecast).to be_a(Forecast)
    expect(forecast.city).to eq('Denver')
    expect(forecast.state).to eq('CO')
  end
  it 'can take location or city/state/lat/long in creating a forecast', :vcr do
    city = 'Denver'
    state = 'CO'
    latitude = '39.7392358'
    longitude = '-104.990251'
    forecast = Forecast.new(city: city, state: state, latitude: latitude, longitude: longitude)
  end
  it 'sets the latitude and longitude for a forecast', :vcr do
    location = 'denver,co'
    forecast = Forecast.new(location: location)
    expect(forecast.latitude).to eq('39.7392358')
    expect(forecast.longitude).to eq('-104.990251')
    
    hawaii_location = 'honolulu,hi'
    hawaii_forecast = Forecast.new(location: hawaii_location)
    expect(hawaii_forecast.latitude).to eq('21.3069444')
    expect(hawaii_forecast.longitude).to eq('-157.8583333')
  end
  it 'sets the date for a forecast', :vcr do
    location = 'denver,co'
    forecast = Forecast.new(location: location)
    expect(forecast.date).to eq(Time.now.strftime('%Y-%m-%d'))
  end
  it 'can get current_weather info', :vcr do
    location = 'denver,co'
    forecast = Forecast.new(location: location)

    weather = forecast.get_current_weather
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
    forecast = Forecast.new(location: 'denver,co')

    expect(forecast.get_weather_days).to be_a(Array)
    expect(forecast.get_weather_days.count).to eq(5)
    expect(forecast.get_weather_days.first).to have_key(:date)
    expect(forecast.get_weather_days.first).to have_key(:icon)
    expect(forecast.get_weather_days.first).to have_key(:summary)
    expect(forecast.get_weather_days.first).to have_key(:precip_probability)
    expect(forecast.get_weather_days.first).to have_key(:temp_high)
    expect(forecast.get_weather_days.first).to have_key(:temp_low)
  end
  it 'can get weather hours', :vcr do
    allow_any_instance_of(Forecast).to receive(:latitude).and_return('12')
    allow_any_instance_of(Forecast).to receive(:longitude).and_return('-12')
    forecast = Forecast.new(location: 'denver,co')
    
    expect(forecast.get_weather_hours).to be_a(Array)
    expect(forecast.get_weather_hours.count).to eq(8)
    expect(forecast.get_weather_hours.first).to have_key(:time)
    expect(forecast.get_weather_hours.first).to have_key(:temperature)
    expect(forecast.get_weather_hours.first).to have_key(:icon)
  end
  it 'creates location record if needed', :vcr do
    location = 'denver,co'
    Forecast.new(location: location)
    loc = Location.last
    expect(loc.city).to eq('Denver')
    expect(loc.state).to eq('CO')
  end
  it 'finds existing location record if present', :vcr do
    location = create(:location)
    loc_string = "#{location.city},#{location.state}"
    Forecast.new(location: loc_string)
    
    expect(Location.last).to eq(location)
  end
end
