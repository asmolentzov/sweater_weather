require 'rails_helper'

describe 'Favorites API' do
  it 'returns 401 if making post request with no API key' do
    post '/api/v1/favorites', params: { location: 'Denver, CO' }
    
    expect(response.status).to eq(401)
    expect(response.body).to be_nil
  end
end