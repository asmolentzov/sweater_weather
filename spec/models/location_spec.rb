require 'rails_helper'

describe Location do
  describe 'Validations' do
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
  end
  
  describe 'Relationships' do
    it { should have_many(:favorites) }
    it { should belong_to(:current_weather) }
  end
  
  describe 'Callbacks' do
    it 'should grab current weather on creation', :vcr do
      location = Location.create!(city: 'Denver', state: 'CO', latitude: '39.7392358', longitude: '-104.990251')
      
      expect(location.current_weather).to be_a(CurrentWeather)
      expect(location.current_weather.temperature).to_not be_nil
      expect(location.current_weather.summary).to_not be_nil
    end
  end
end