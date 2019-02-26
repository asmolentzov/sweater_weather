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
  it 'creates a favorite', :vcr do
    user = User.create(email: 'email', password: 'password')
    location = create(:location)
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
  it 'returns a list of a users favorites when one favorite', :vcr do
    user = User.create(email: 'email', password: 'password')
    location = create(:location)
    user.favorites.create(location: location)
    get '/api/v1/favorites', params: { api_key: user.api_key }
    
    expect(response.status).to eq(200)
    favorites = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(favorites).to be_a(Array)
    expect(favorites.first).to be_a(Hash)
    expect(favorites.first[:attributes]).to have_key(:location)
    expect(favorites.first[:attributes][:location]).to eq("#{location.city}, #{location.state}")
    expect(favorites.first[:attributes]).to have_key(:current_weather)
    expect(favorites.first[:attributes][:current_weather]).to have_key(:temperature)
    expect(favorites.first[:attributes][:current_weather]).to have_key(:temp_feels_like)
    expect(favorites.first[:attributes][:current_weather]).to have_key(:temp_high)
    expect(favorites.first[:attributes][:current_weather]).to have_key(:temp_low)
    expect(favorites.first[:attributes][:current_weather]).to have_key(:humidity)
    expect(favorites.first[:attributes][:current_weather]).to have_key(:visibility)
    expect(favorites.first[:attributes][:current_weather]).to have_key(:uv_index)
    expect(favorites.first[:attributes][:current_weather]).to have_key(:summary)
    expect(favorites.first[:attributes][:current_weather]).to have_key(:summary_short)
    expect(favorites.first[:attributes][:current_weather]).to have_key(:summary_tonight)
  end
  it 'returns a list of a users favorites when multiple favorites', :vcr do
    user = User.create(email: 'email', password: 'password')
    location = create(:location)
    location_2 = create(:location)
    user.favorites.create(location: location)
    user.favorites.create(location: location_2)
    get '/api/v1/favorites', params: { api_key: user.api_key }
    
    expect(response.status).to eq(200)
    favorites = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(favorites).to be_a(Array)
    expect(favorites.first).to be_a(Hash)
    expect(favorites.first[:attributes]).to have_key(:location)
    expect(favorites.last[:attributes][:location]).to eq("#{location.city}, #{location.state}")
    expect(favorites.last[:attributes]).to have_key(:current_weather)
    expect(favorites.last[:attributes][:current_weather]).to have_key(:temperature)
  end
  it 'does not return a list of favorites when incorrect API key' do
    user = User.create(email: 'email', password: 'password')
    get '/api/v1/favorites', params: { api_key: 'not api key' }
    
    expect(response.status).to eq(401)
  end
  it 'does not return a list of favorites when no API key' do
    user = User.create(email: 'email', password: 'password')    
    get '/api/v1/favorites', params: { api_key: nil }

    expect(response.status).to eq(401)
  end
  it 'can delete favorites' do
    user = User.create(email: 'email', password: 'password')
    location_1 = create(:location)
    location_2 = create(:location)
    favorite_1 = user.favorites.create(location: location_1)
    favorite_2 = user.favorites.create(location: location_2)
    
    delete '/api/v1/favorites', params: {
                                          location: location_1.id,
                                          api_key: user.api_key
                                        }
    expect(response.status).to eq(200)
    favorites = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(favorites).to be_a(Array)
    expect(favorites.first).to be_a(Hash)
    expect(favorites.first[:attributes]).to have_key(:location)
    expect(favorites.last[:attributes][:location]).to eq("#{location_1.city}, #{location_1.state}")
    expect(favorites.last[:attributes]).to have_key(:current_weather)
    expect(favorites.last[:attributes][:current_weather]).to have_key(:temperature)
    expect(Favorite.all.count).to eq(1)
    expect(Favorite.all).to eq([favorite_2])
    expect(Location.all.count).to eq(2)
  end
  it 'does not delete favorite if request has wrong api key' do
    user = User.create(email: 'email', password: 'password')
    location_1 = create(:location)
    favorite_1 = user.favorites.create(location: location_1)
    
    delete '/api/v1/favorites', params: { 
                                          location: location_1.id,
                                          api_key: 'not api key' }
    expect(response.status).to eq(401)
  end
  it 'does not delete favorite if request does not have api key' do
    user = User.create(email: 'email', password: 'password')
    location_1 = create(:location)
    favorite_1 = user.favorites.create(location: location_1)
    
    delete '/api/v1/favorites', params: { 
                                          location: location_1.id,
                                        }
    expect(response.status).to eq(401)
  end
end