class CurrentWeather < ApplicationRecord
  validates_presence_of(:temperature)
  validates_presence_of(:temp_feels_like)
  validates_presence_of(:temp_high)
  validates_presence_of(:temp_low)
  validates_presence_of(:humidity)
  validates_presence_of(:visibility)
  validates_presence_of(:uv_index)
  validates_presence_of(:summary)
  validates_presence_of(:summary_short)
  validates_presence_of(:summary_tonight)
  
  has_one :location
end