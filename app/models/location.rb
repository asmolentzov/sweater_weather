class Location < ApplicationRecord
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :latitude
  validates_presence_of :longitude
  
  has_many :favorites
  belongs_to :current_weather, optional: true
  
  after_create :get_current_weather
  
  private
  
  def get_current_weather
    self.current_weather = CurrentWeather.create(weather.current_weather)
  end
  
  def weather
    @_weather ||= Weather.new(latitude, longitude)
  end
end