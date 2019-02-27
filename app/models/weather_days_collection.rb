class WeatherDaysCollection < ApplicationRecord
  validates_presence_of :weather_days_data
  has_one :location
end