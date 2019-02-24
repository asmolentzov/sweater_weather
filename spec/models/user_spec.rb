require 'rails_helper'

describe User do
  describe 'Validations' do
    it { should validate_presence_of(:email) }
  end
end