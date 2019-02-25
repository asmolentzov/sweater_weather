require 'rails_helper'

describe 'Sessions API' do
  it 'returns an API key when it receives a POST request' do
    user = User.create(email: 'email@example.com', password: 'password')
    
    post '/api/v1/sessions', params: {
                                      email: user.email,
                                      password: user.password
    }
    
    expect(response.status).to eq(200)
    result = JSON.parse(response.body, symbolize_names: true)
    
    expect(result).to have_key(:api_key)
    expect(result[:api_key]).to eq(user.api_key)
  end
end