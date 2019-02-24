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
  it 'can get current_weather info', :vcr do
    allow_any_instance_of(WeatherService).to receive(:get_weather).and_return(JSON.parse(File.read(Rails.root.join('spec/fixtures/weather_data.txt')), symbolize_names: true))
    current_weather_day_info = {
                                temp_feels_like: 35,
                                temp_high: 37,
                                temp_low: 18,
                                humidity: 0.55,
                                visibility: 10.00,
                                uv_index: 4,
                                summary: "Light snow (< 1 in.) until afternoon.",
                                summary_short: 'Partly Cloudy',
                                summary_tonight: "Light snow (< 1 in.) until afternoon."
    }
    expect(@forecast.get_current_weather). to eq(current_weather_day_info)
  end
  it 'can get weather days', :vcr do
    allow_any_instance_of(Forecast).to receive(:latitude).and_return('12')
    allow_any_instance_of(Forecast).to receive(:longitude).and_return('-12')
    forecast = Forecast.new('denver,co')

    expect(forecast.get_weather_days).to be_a(Array)
    expect(forecast.get_weather_days.count).to eq(5)
    expect(forecast.get_weather_days.first).to have_key(:date)
    expect(forecast.get_weather_days.first).to have_key(:summary)
    expect(forecast.get_weather_days.first).to have_key(:precip_probability)
    expect(forecast.get_weather_days.first).to have_key(:temp_high)
    expect(forecast.get_weather_days.first).to have_key(:temp_low)
  end
end
