require 'rails_helper'

describe Favorite do
  describe 'Validations' do
    it { should validate_presence_of(:location) }
  end
  
  describe 'Relationships' do
    it { should belong_to(:user) }
  end
end