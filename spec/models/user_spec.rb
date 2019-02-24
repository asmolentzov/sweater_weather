require 'rails_helper'

describe User do
  describe 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end
  
  describe 'Callbacks' do
    it 'should add api_key on user creation' do
      user = User.create(email: 'user@example.com', password: 'password')
      
      expect(user.api_key).to_not be_nil
    end
  end
end