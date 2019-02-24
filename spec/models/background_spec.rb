require 'rails_helper'

describe Background do
  it 'exists and has attributes', :vcr do
    background = Background.new('denver,co')
    expect(background).to be_a(Background)
    expect(background.city).to eq('denver')
    expect(background.state).to eq('co')
    
    hawaii_background = Background.new('honolulu,hi')
    expect(hawaii_background.city).to eq('honolulu')
    expect(hawaii_background.state).to eq('hi')
  end
  it 'returns a background image url', :vcr do
    background = Background.new('denver,co')
    uri = URI.parse(background.image_url)
    expect(uri.scheme).to eq('https')
    expect(uri.host.split('.')[1]).to eq('staticflickr')
    expect(uri.host.split('.')[2]).to eq('com')
  end
end