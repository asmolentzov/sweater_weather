require 'rails_helper'

describe 'Image API' do
  it 'returns an image for the city/state requested', :vcr do
    get '/api/v1/backgrounds?location=denver,co'
    
    expect(response).to be_successful
    image = JSON.parse(response.body, symbolize_names: true)
    expect(image[:data][:attributes]).to have_key(:image_url)
    uri = URI.parse(image[:data][:attributes][:image_url])
    expect(uri.scheme).to eq('https')
    expect(uri.host.split('.')[1]).to eq('staticflickr')
    expect(uri.host.split('.')[2]).to eq('com')
  end
end