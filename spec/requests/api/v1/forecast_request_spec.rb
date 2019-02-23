require 'rails_helper'

describe 'Forecast API' do
  it 'gets the lat/long from the city/state requested' do
    get '/api/v1/forecast?location=denver,co'
    
    forecast = Forecast.last
    
    expect(response).to be_successful
    
    expect(forecast.city).to eq('Denver')
    expect(forecast.state).to eq('CO')
    expect(forecast.latitude).to eq('39.7392358')
    expect(forecast.longitude).to eq('-104.990251')
  end
end