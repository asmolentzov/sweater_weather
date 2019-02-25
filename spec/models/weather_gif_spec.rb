require 'rails_helper'

describe WeatherGif do
  it 'exists and has attributes' do
    location = 'denver,co'
    weather_gif = WeatherGif.new(location)
    expect(weather_gif).to be_a(WeatherGif)
    expect(weather_gif.location).to eq(location)
  end
  
  it 'has images' do
    location = 'denver,co'
    weather_gif = WeatherGif.new(location)
    
    expect(weather_gif.images).to be_a(Array)
    expect(weather_gif.images.count).to eq(5)
    # expect(weather_gif.images.first).to be_a(Gif)
  end
end