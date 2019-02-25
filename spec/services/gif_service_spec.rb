require 'rails_helper'

describe GifService do
  it 'exists' do
    service = GifService.new
    expect(service).to be_a(GifService)
  end
  
  it 'can get gif url', :vcr do
    summary = 'partly cloudy through evening'
    service = GifService.new
    gif_url = service.get_gif(summary)
    expect(gif_url).to be_a(String)
    uri = URI.parse(gif_url)
    expect(uri.host.split('.').second).to eq('giphy')
    expect(uri.host.split('.').last).to eq('com')
  end
end