require 'rails_helper'

describe CurrentWeather do
  describe 'Validations' do
    it { should validate_presence_of(:temperature) }
    it { should validate_presence_of(:temp_feels_like) }
    it { should validate_presence_of(:temp_high) }
    it { should validate_presence_of(:temp_low) }
    it { should validate_presence_of(:humidity) }
    it { should validate_presence_of(:visibility) }
    it { should validate_presence_of(:uv_index) }
    it { should validate_presence_of(:summary) }
    it { should validate_presence_of(:summary_short) }
    it { should validate_presence_of(:summary_tonight) }
  end
  
  describe 'Relationships' do
    it { should have_one(:location) }
  end
end