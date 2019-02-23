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
end