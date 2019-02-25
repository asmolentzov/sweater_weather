require 'rails_helper'

describe WeatherGif do
  it 'exists and has attributes' do
    date = '2019-02-25'
    summary = 'Partly cloudy through the afternoon'
    weather_gif = WeatherGif.new(date, summary)
    
    expect(weather_gif).to be_a(WeatherGif)
    expect(weather_gif.time).to eq(Time.new(date).to_i)
    expect(weather_gif.weather_summary).to eq(summary)
  end
end