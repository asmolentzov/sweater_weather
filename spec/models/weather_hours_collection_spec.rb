require 'rails_helper'

describe WeatherHoursCollection do
  describe 'Validations' do
    it { should validate_presence_of(:weather_hours_data) }
  end
  describe 'Relationships' do
    it { should have_one(:location) }
  end
end