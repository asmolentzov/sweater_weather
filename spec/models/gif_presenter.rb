require 'rails_helper'

describe GifPresenter do
  it 'exists and has attributes' do
    location = 'denver,co'
    gifs = GifPresenter.new(location)
    expect(gifs).to be_a(GifPresenter)
    expect(gifs.location).to eq(location)
  end
  
  it 'has images', :vcr do
    location = 'denver,co'
    gifs = GifPresenter.new(location)
    
    expect(gifs.images).to be_a(Array)
    expect(gifs.images.count).to eq(5)
  end
end