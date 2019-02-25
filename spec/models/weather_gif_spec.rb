require 'rails_helper'

describe WeatherGif do
  it 'exists and has attributes' do
    location = 'denver,co'
    weather_gif = WeatherGif.new(location)
    expect(weather_gif).to be_a(WeatherGif)
    expect(weather_gif.location).to eq(location)
  end
end