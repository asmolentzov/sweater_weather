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
    expect(user.password).to eq(password)
  end
end