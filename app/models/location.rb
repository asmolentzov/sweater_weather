class Location < ApplicationRecord
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :latitude
  validates_presence_of :longitude
  
  has_many :favorites
  belongs_to :current_weather
  belongs_to :weather_hours_collection
  belongs_to :weather_days_collection
end