require 'rails_helper'

describe WeatherDaysCollection do
  describe 'Validations' do
    it { should validate_presence_of(:weather_days_data) }
  end
end