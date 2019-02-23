class CreateForecasts < ActiveRecord::Migration[5.2]
  def change
    create_table :forecasts do |t|
      t.string :city
      t.string :state
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
