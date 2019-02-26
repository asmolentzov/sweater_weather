class AddCurrentWeatherToLocation < ActiveRecord::Migration[5.2]
  def change
    add_reference :locations, :current_weather, foreign_key: true
  end
end
