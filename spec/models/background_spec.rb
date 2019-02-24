require 'rails_helper'

describe Background do
  it 'exists and has attributes' do
    background = Background.new('denver,co')
    
    expect(background).to be_a(Background)
    expect(background.city).to eq('denver')
    expect(background.state).to eq('co')
  end
end