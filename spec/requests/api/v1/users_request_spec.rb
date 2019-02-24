require 'rails_helper' 

describe 'Users API' do
  it 'creates a user when it receives a POST request' do
    email = 'whatever@example.com'
    password = 'password'
    post '/api/v1/users', params: { 
                                  email: email, 
                                  password: password, 
                                  password_confirmation: password
                                }
    
    user = User.last
    expect(user.email).to eq(email)
    expect(user.password_digest).to_not be_nil
  end
  it 'returns an api key when it creates a user' do
    email = 'whatever@example.com'
    password = 'password'
    post '/api/v1/users', params: { 
                                  email: email, 
                                  password: password, 
                                  password_confirmation: password
                                }
    expect(response.status).to eq(201)
    result = JSON.parse(response.body, symbolize_names: true)
    expect(result).to have_key(:api_key)
    user = User.last
    expect(user.api_key).to eq(result[:api_key])
  end
end