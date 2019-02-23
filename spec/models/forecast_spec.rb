require 'rails_helper'

RSpec.describe Forecast, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
  end
end
