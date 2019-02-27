class CreateWeatherDaysCollection < ActiveRecord::Migration[5.2]
  def change
    create_table :weather_days_collections do |t|
      t.jsonb :weather_days_data
      t.timestamps
    end
  end
end
