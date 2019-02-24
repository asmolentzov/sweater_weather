require 'rails_helper'

describe ImageService do
  it 'exists and has attributes' do
    city = 'denver'
    state = 'co'
    image_service = ImageService.new(city, state)
    
    expect(image_service).to be_a(ImageService)
    expect(image_service.city).to eq(city)
    expect(image_service.state).to eq(state)
  end
  it 'can get an image' do
    city = 'denver'
    state = 'co'
    image_service = ImageService.new(city, state)
    
    image_url = image_service.get_image
    uri = URI.parse(image_url)
    expect(uri.scheme).to eq('https')
    expect(uri.host.split('.')[1]).to eq('staticflickr')
    expect(uri.host.split('.')[2]).to eq('com')
  end
end