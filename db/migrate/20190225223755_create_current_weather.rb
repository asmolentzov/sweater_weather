class CreateCurrentWeather < ActiveRecord::Migration[5.2]
  def change
    create_table :current_weathers do |t|
      t.float :temperature
      t.float :temp_feels_like
      t.float :temp_high
      t.float :temp_low
      t.float :humidity
      t.float :visibility
      t.float :uv_index
      t.string :summary
      t.string :summary_short
      t.string :summary_tonight
      
      t.timestamps
    end
  end
end
