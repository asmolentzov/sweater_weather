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
    weather_data = { "currently": {
        "summary": "Partly Cloudy",
        "icon": "partly-cloudy-day",
        "temperature": 34.97,
        "apparentTemperature": 34.97,
        "humidity": 0.55,
        "uvIndex": 4,
        "visibility": 10,
    },
    "hourly": {
        "summary": "Light snow later this afternoon.",
        "icon": "snow",
        "data": [
            {
                "summary": "Light Snow",
                "temperature": 34.96,
                "apparentTemperature": 34.96,
                "humidity": 0.55,
                "uvIndex": 4,
                "visibility": 10
            }
        ]
    },
    "daily": {
        "summary": "Snow (2–4 in.) today and next Saturday, with high temperatures peaking at 58°F on Tuesday.",
        "icon": "snow",
        "data": [
            {
                "time": 1550905200,
                "summary": "Light snow (< 1 in.) until afternoon.",
                "icon": "snow"
              }
            ]
          }
        }
    allow_any_instance_of(WeatherService).to receive(:get_weather).and_return(weather_data)
    current_weather_day_info = {
                                temp_feels_like: 35,
                                humidity: 0.55,
                                visibility: 10.00,
                                uv_index: 4,
                                summary: "Light snow (< 1 in.) until afternoon.",
                                summary_short: 'Partly Cloudy',
                                summary_tonight: "Light snow (< 1 in.) until afternoon."
    }
    expect(weather.current_weather_day).to eq(current_weather_day_info)
  end
  
  it 'can return weather days' do
    lat = '12'
    long = '-12'
    weather = Weather.new(lat, long)
    weather_day = {
                    summary: 'Partly Cloudy',
                    precip_probability: 0,
                    temp_high: 37,
                    temp_low: 18
    }
    
    expect(weather.weather_days).to be_a(Array)
    expect(weather.weather_days.count).to eq(5)
    expect(weather.weather_days.first).to eq(weather_day)
    weather.weather_days.each do |day|
      expect(day).to have_key(:summary)
      expect(day).to have_key(:precip_probability)
      expect(day).to have_key(:temp_high)
      expect(day).to have_key(:temp_low)
    end
  end
end