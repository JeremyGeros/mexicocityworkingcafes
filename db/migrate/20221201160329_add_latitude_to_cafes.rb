class AddLatitudeToCafes < ActiveRecord::Migration[7.0]
  def change
    add_column :cafes, :latitude, :float
    add_column :cafes, :longitude, :float
  end
end
