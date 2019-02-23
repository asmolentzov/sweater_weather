require 'rails_helper' 

describe WeatherService do
  it 'exists and has attributes' do
    lat = '12'
    long = '-12'
    weather_service = WeatherService.new(lat, long)
    
    expect(weather_service).to be_a(WeatherService)
    expect(weather_service.latitude).to eq(lat)
    expect(weather_service.longitude).to eq(long)
  end
  it 'can get weather' do
    lat = '12'
    long = '-12'
    weather_service = WeatherService.new(lat, long)
    
    weather_data = weather_service.get_weather
    expect(weather_data).to have_key(:daily)
    expect(weather_data).to have_key(:hourly)
    expect(weather_data).to have_key(:currently)
    expect(weather_data[:currently]).to have_key(:apparentTemperature)
    expect(weather_data[:currently]).to have_key(:humidity)
    expect(weather_data[:hourly]).to have_key(:summary)
    expect(weather_data[:hourly][:data].first).to have_key(:temperature)
    expect(weather_data[:daily][:data].first).to have_key(:icon)
    expect(weather_data[:daily][:data].first).to have_key(:precipProbability)
    expect(weather_data[:daily][:data].first).to have_key(:temperatureLow)
    expect(weather_data[:daily][:data].first).to have_key(:temperatureHigh)
  end
end