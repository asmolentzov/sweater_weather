require 'rails_helper'

describe Favorite do
  describe 'Validations' do
    it { should validate_presence_of(:location) }
  end
  
  describe 'Relationships' do
    it { should belong_to(:user) }
  end
  
  describe 'Callbacks' do
    it 'gets weather data after being created' do
      favorite = Favorite.create(location: 'Denver,CO')
      expect(favorite.current_weather).to have_key(:temperature)
      expect(favorite.current_weather[:temperature]).to_not be_nil
      expect(favorite.current_weather).to have_key(:temp_feels_like)
      expect(favorite.current_weather).to have_key(:temp_high)
      expect(favorite.current_weather).to have_key(:temp_low)
      expect(favorite.current_weather).to have_key(:humidity)
      expect(favorite.current_weather).to have_key(:visibility)
      expect(favorite.current_weather).to have_key(:uv_index)
      expect(favorite.current_weather).to have_key(:summary)
      expect(favorite.current_weather).to have_key(:summary_short)
      expect(favorite.current_weather).to have_key(:summary_tonight)
    end
  end
end