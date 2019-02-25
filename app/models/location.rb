class Location < ApplicationRecord
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :latitude
  validates_presence_of :longitude
  
  has_many :favorites
  belongs_to :current_weather
  
  after_commit :get_current_weather
  
  private
  
  def get_current_weather
    CurrentWeather.create(Forecast.new(city: city, state: state, latitude: latitude, longitude: longitude).get_current_weather)
  end
end