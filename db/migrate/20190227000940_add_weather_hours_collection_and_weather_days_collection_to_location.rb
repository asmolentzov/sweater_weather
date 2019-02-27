class AddWeatherHoursCollectionAndWeatherDaysCollectionToLocation < ActiveRecord::Migration[5.2]
  def change
    add_reference :locations, :weather_hours_collection, foreign_key: true
    add_reference :locations, :weather_days_collection, foreign_key: true
  end
end
