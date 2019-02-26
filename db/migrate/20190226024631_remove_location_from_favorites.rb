class RemoveLocationFromFavorites < ActiveRecord::Migration[5.2]
  def change
    remove_column :favorites, :location, :string
  end
end
