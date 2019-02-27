require 'rails_helper'

describe Location do
  describe 'Validations' do
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
  end
  
  describe 'Relationships' do
    it { should have_many(:favorites) }
    it { should belong_to(:current_weather) }
    it { should belong_to(:weather_hours_collection) }
    it { should belong_to(:weather_days_collection) }
  end
end