require 'rails_helper'

describe GifService do
  it 'exists' do
    service = GifService.new
    expect(service).to be_a(GifService)
  end
  
  it 'can get gif url', :vcr do
    phrase = 'partly cloudy through evening'
    service = GifService.new
    gif_url = service.get_gif(phrase)
    expect(gif_url).to be_a(String)
    uri = URI.parse(gif_url)
    expect(uri.host.split('.').second).to eq('giphy')
    expect(uri.host.split('.').last).to eq('com')
  end
  
  it 'can get different gif urls', :vcr do
    phrase_1 = 'partly cloudy through evening'
    phrase_2 = 'sunny and clear'
    service = GifService.new
    gif_url_1 = service.get_gif(phrase_1)
    gif_url_2 = service.get_gif(phrase_2)
    
    expect(gif_url_1).to_not eq(gif_url_2)
    expect(gif_url_2).to be_a(String)
    uri = URI.parse(gif_url_2)
    expect(uri.host.split('.').second).to eq('giphy')
    expect(uri.host.split('.').last).to eq('com')
  end
end