require 'rails_helper'

describe GifService do
  it 'exists' do
    service = GifService.new
    expect(service).to be_a(GifService)
  end
end