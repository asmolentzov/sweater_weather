require 'rails_helper'

describe 'Image API' do
  it 'returns an image for the city/state requested', :vcr do
    get '/api/v1/backgrounds?location=denver,co'
    
    image = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response[:data][:attributes]).to have_key(:image_url)
    uri = URI.parse(response[:data][:attributes][:image_url])
    expect(uri.scheme).to eq('https')
    expect(uri.host.split('.')[1]).to eq('staticflickr')
    expect(uri.host.split('.')[2]).to eq('com')
  end
end