class Forecast < ApplicationRecord
  validates_presence_of(:city)
  validates_presence_of(:state)
  
  before_create :set_lat_long, :set_date
  
  private
  
  def set_lat_long
    self.latitude = LocationService.new(city, state).get_latitude
    self.longitude = LocationService.new(city, state).get_longitude
  end
  
  def set_date
    self.date = Time.now.strftime('%Y-%m-%d')
  end
end