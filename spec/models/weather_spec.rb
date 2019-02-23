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
end