require 'rails_helper'

describe 'Favorites API' do
  it 'returns 401 if making post request with no API key' do
    post '/api/v1/favorites', params: { location: 'Denver, CO' }
    
    expect(response.status).to eq(401)
    expect(response.body).to eq('{}')
  end
  it 'returns 401 if making post request with incorrect API key' do
    user = User.create(email: 'email', password: 'password')
    
    post '/api/v1/favorites', params: {
                                        location: 'Denver, CO',
                                        api_key: 'not an api key'
                                      }
    
    expect(response.status).to eq(401)
    expect(response.body).to eq('{}')
  end
  it 'creates a favorite' do
    user = User.create(email: 'email', password: 'password')
    location = Location.create(city: 'Denver', state: 'CO', latitude: '12', longitude: '-12')
    post '/api/v1/favorites', params: {
                                        location: location.id,
                                        api_key: user.api_key
                                      }
    expect(response).to be_successful
    favorite = Favorite.last
    expect(favorite.location).to eq(location)
    expect(favorite.user).to eq(user)
  end
  it 'returns a list of a users favorites - empty if no favorites' do
    user = User.create(email: 'email', password: 'password')
    get '/api/v1/favorites', params: { api_key: user.api_key }
    
    expect(response.status).to eq(200)
    favorites = JSON.parse(response.body, symbolize_names: true)
    expect(favorites[:data]).to be_empty
  end
  it 'returns a list of a users favorites' do
    user = User.create(email: 'email', password: 'password')
    location = Location.create(city: 'Denver', state: 'CO', latitude: '12', longitude: '-12')
    location_2 = Location.create(city: 'Honolulu', state: 'HI', latitude: '12', longitude: '-12')
    user.favorites.create(location: location)
    user.favorites.create(location: location_2)
    get '/api/v1/favorites', params: { api_key: user.api_key }
    
    expect(response.status).to eq(200)
    favorites = JSON.parse(response.body, symbolize_names: true)
    require 'pry'; binding.pry
    
    expect(favorites).to be_a(Array)
    expect(favorites.first).to be_a(Hash)
    expect(favorites.first).to have_key(:location)
    expect(favorites.first[:location]).to eq(location)
    expect(favorites.first).to have_key(:current_weather)
    expect(favorites.first[:current_weather]).to have_key(:temperature)
    expect(favorites.first[:current_weather]).to have_key(:temp_feels_like)
    expect(favorites.first[:current_weather]).to have_key(:temp_high)
    expect(favorites.first[:current_weather]).to have_key(:temp_low)
    expect(favorites.first[:current_weather]).to have_key(:humidity)
    expect(favorites.first[:current_weather]).to have_key(:visibility)
    expect(favorites.first[:current_weather]).to have_key(:uv_index)
    expect(favorites.first[:current_weather]).to have_key(:summary)
    expect(favorites.first[:current_weather]).to have_key(:summary_short)
    expect(favorites.first[:current_weather]).to have_key(:summary_tonight)
    expect(favorites.last[:location]).to eq(location_2)
    expect(favorites.last).to have_key(:current_weather)
  end
end