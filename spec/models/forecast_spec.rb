require 'rails_helper'

describe Forecast do
  # before(:each) do
  #   location = 'denver,co'
  #   forecast = Forecast.new(location: location)
  # end
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
    allow_any_instance_of(WeatherService).to receive(:get_weather).and_return(JSON.parse(File.read(Rails.root.join('spec/fixtures/weather_data.txt')), symbolize_names: true))
    current_weather_day_info = {
                                temperature: 34.97,
                                temp_feels_like: 34.97,
                                temp_high: 37.22,
                                temp_low: 17.63,
                                humidity: 0.55,
                                visibility: 10,
                                uv_index: 4,
                                summary: "Light snow (< 1 in.) until afternoon.",
                                summary_short: 'Partly Cloudy',
                                summary_tonight: "Light snow (< 1 in.) until afternoon."
    }
    expect(forecast.get_current_weather). to eq(current_weather_day_info)
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
  it 'finds or creates location record', :vcr do
    location = 'denver,co'
    Forecast.new(location: location)
    
    loc = Location.last
    loc.city = 'Denver'
    loc.state = 'CO'
  end
end
