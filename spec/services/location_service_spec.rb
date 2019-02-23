require 'rails_helper' 

describe LocationService do
  it 'exists and has attributes' do
    location_service = LocationService.new("Denver", "CO")
    
    expect(location_service).to be_a(LocationService)
    expect(location_service.city).to eq("Denver")
    expect(location_service.state).to eq("CO")
  end
  it 'can get latitude for a city/state' do
    
  end
end