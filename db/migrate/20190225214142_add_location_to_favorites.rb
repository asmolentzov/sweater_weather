class AddLocationToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_reference :favorites, :location, foreign_key: true
  end
end
