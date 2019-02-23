require 'rails_helper' 

describe LocationService do
  it 'exists and has attributes' do
    location_service = LocationService.new("Denver", "CO")
    
    expect(location_service).to be_a(LocationService)
    expect(location_service.city).to eq("Denver")
    expect(location_service.state).to eq("CO")
  end
  it 'can get latitude for a city/state' do
    location_service = LocationService.new("Denver", "CO")
    expec(location_service.get_latitude).to eq('39.7392')
    
    location_service = LocationService.new("Honolulu", "HI")
    expec(location_service.get_latitude).to eq('21.3069')
  end
  it 'can get longitude for a city/state' do
    location_service = LocationService.new("Denver", "CO")
    expec(location_service.get_longitude).to eq('104.9903')
    
    location_service = LocationService.new("Honolulu", "HI")
    expec(location_service.get_longitude).to eq('157.8583')
  end
end