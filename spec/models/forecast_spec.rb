require 'rails_helper'

describe Forecast do
  before(:each) do
    location = 'denver,co'
    @forecast = Forecast.new(location)
  end
  it 'exists and has basic attributes' do
    expect(@forecast).to be_a(Forecast)
    expect(@forecast.city).to eq('Denver')
    expect(@forecast.state).to eq('CO')
  end
  it 'sets the latitude and longitude for a forecast' do
    expect(@forecast.latitude).to eq('39.7392358')
    expect(@forecast.longitude).to eq('-104.990251')
    
    hawaii_location = 'honolulu,hi'
    hawaii_forecast = Forecast.new(hawaii_location)
    expect(hawaii_forecast.latitude).to eq('21.3069444')
    expect(hawaii_forecast.longitude).to eq('-157.8583333')
  end
  it 'sets the date for a forecast' do
    expect(@forecast.date).to eq(Time.now.strftime('%Y-%m-%d'))
  end
end
