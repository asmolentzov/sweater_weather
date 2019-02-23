class Forecast < ApplicationRecord
  validates_presence_of(:city)
  validates_presence_of(:state)
  
  before_create :get_lat_long
  
  private
  
  def get_lat_long
    self.latitude = LocationService.new(city, state).get_latitude
    self.longitude = LocationService.new(city, state).get_longitude
  end
end