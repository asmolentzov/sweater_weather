require 'rails_helper'

describe Forecast do
  before(:each) do
    location = 'denver,co'
    @forecast = Forecast.new(location)
  end
  it 'exists and has basic attributes', :vcr do
    expect(@forecast).to be_a(Forecast)
    expect(@forecast.city).to eq('Denver')
    expect(@forecast.state).to eq('CO')
  end
  it 'sets the latitude and longitude for a forecast', :vcr do
    expect(@forecast.latitude).to eq('39.7392358')
    expect(@forecast.longitude).to eq('-104.990251')
    
    hawaii_location = 'honolulu,hi'
    hawaii_forecast = Forecast.new(hawaii_location)
    expect(hawaii_forecast.latitude).to eq('21.3069444')
    expect(hawaii_forecast.longitude).to eq('-157.8583333')
  end
  it 'sets the date for a forecast', :vcr do
    expect(@forecast.date).to eq(Time.now.strftime('%Y-%m-%d'))
  end
  it 'can get current_weather_day info', :vcr do
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
    expect(@forecast.get_current_weather_day). to eq(current_weather_day_info)
  end
end
