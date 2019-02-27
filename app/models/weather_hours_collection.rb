class WeatherHoursCollection < ApplicationRecord
  validates_presence_of :weather_hours_data
  has_one :location
end