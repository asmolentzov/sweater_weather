require 'rails_helper' 

describe Weather do
  it 'exists and has attributes' do
    lat = '12'
    long = '-12'
    weather = Weather.new(lat, long)
    
    expect(weather).to be_a(Weather)
    expect(weather.latitude).to eq(lat)
    expect(weather.longitude).to eq(long)
  end
  
  it 'can return current weather day info' do
    lat = '12'
    long = '-12'
    weather = Weather.new(lat, long)
    current_weather_day_info = {
                                temp_feels_like: 30,
                                humidity: 0.75,
                                visibility: 10.00,
                                uv_index: 2,
                                summary: 'Mostly cloudy until afternoon',
                                summary_short: 'Partly Cloudy',
                                summary_tonight: 'Partly cloudy starting tonight, continuing until tomorrow morning'
    }
    expect(weather.current_weather_day).to eq(current_weather_day_info)
  end
end