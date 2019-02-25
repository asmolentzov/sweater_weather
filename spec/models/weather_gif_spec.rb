require 'rails_helper'

describe WeatherGif do
  it 'exists and has attributes' do
    date = '2019-02-25'
    summary = 'Partly cloudy through the afternoon'
    weather_gif = WeatherGif.new(date, summary)
    
    expect(weather_gif).to be_a(WeatherGif)
    expect(weather_gif.time).to eq(Time.new(date).to_i)
    expect(weather_gif.summary).to eq(summary)
  end
  it 'has a gif url', :vcr do
    date = '2019-02-25'
    summary = 'Partly cloudy through the afternoon'
    weather_gif = WeatherGif.new(date, summary)
    
    expect(weather_gif.url).to be_a(String)
    uri = URI.parse(weather_gif.url)
    expect(uri.host.split('.').second).to eq('giphy')
    expect(uri.host.split('.').last).to eq('com')
  end
end