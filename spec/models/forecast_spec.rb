require 'rails_helper'

RSpec.describe Forecast, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
  end
  
  describe 'Callbacks' do
    describe 'get_lat_long' do
      it 'gets the latitude and longitude for a forecast' do
        forecast = Forecast.create(city: 'Denver', state: 'CO')
        expect(forecast.latitude).to eq('39.7392358')
        expect(forecast.longitude).to eq('-104.990251')
        
        hawaii_forecast = Forecast.create(city: 'Honolulu', state: 'HI')
        expect(hawaii_forecast.latitude).to eq('21.3069444')
        expect(hawaii_forecast.longitude).to eq('-157.8583333')
      end
    end
  end
end
