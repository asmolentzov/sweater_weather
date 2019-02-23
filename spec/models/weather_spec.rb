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
end