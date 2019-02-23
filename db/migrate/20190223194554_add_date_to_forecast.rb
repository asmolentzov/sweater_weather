class AddDateToForecast < ActiveRecord::Migration[5.2]
  def change
    add_column :forecasts, :date, :string
  end
end
