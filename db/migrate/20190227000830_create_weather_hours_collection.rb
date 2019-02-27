class CreateWeatherHoursCollection < ActiveRecord::Migration[5.2]
  def change
    create_table :weather_hours_collections do |t|
      t.jsonb :weather_hours_data
    end
  end
end
