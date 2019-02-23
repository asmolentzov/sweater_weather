class Forecast < ApplicationRecord
  validates_presence_of(:city)
  validates_presence_of(:state)
end