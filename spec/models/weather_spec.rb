require 'rails_helper' 

describe Weather do
  before(:each) do
    @weather_data = JSON.parse(File.read(Rails.root.join('spec/fixtures/weather_data.txt')), symbolize_names: true)
  end
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
    
    allow_any_instance_of(WeatherService).to receive(:get_weather).and_return(@weather_data)
    current_weather_day_info = {
                                temperature: 35,
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
    expect(weather.current_weather).to eq(current_weather_day_info)
  end
  
  it 'can return weather days', :vcr do
    lat = '12'
    long = '-12'
    weather = Weather.new(lat, long)
    weather_day = {
                    date: '2019-02-23',
                    summary: 'snow',
                    precip_probability: 0.55,
                    precip_type: 'snow',
                    temp_high: 37,
                    temp_low: 18
    }
    allow_any_instance_of(Weather).to receive(:weather_data).and_return(@weather_data)
    
    expect(weather.weather_days(5)).to be_a(Array)
    expect(weather.weather_days(5).count).to eq(5)
    expect(weather.weather_days(5).first).to eq(weather_day)
    weather.weather_days(5).each do |day|
      expect(day).to have_key(:summary)
      expect(day).to have_key(:precip_probability)
      expect(day).to have_key(:temp_high)
      expect(day).to have_key(:temp_low)
    end
  end
  
  it 'can return weather hours' do
    lat = '12'
    long = '-12'
    weather = Weather.new(lat, long)
    weather_hour = {
                    time: 1550948400,
                    temperature: 35,
                    icon: 'snow'
    }
    allow_any_instance_of(Weather).to receive(:weather_data).and_return(@weather_data)
    expect(weather.weather_hours(8)).to be_a(Array)
    expect(weather.weather_hours(8).count).to eq(8)
    expect(weather.weather_hours(8).first).to eq(weather_hour)
    weather.weather_hours(8).each do |hour|
      expect(hour).to have_key(:time)
      expect(hour).to have_key(:temperature)
      expect(hour).to have_key(:icon)
    end
  end
end