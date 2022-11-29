class AddUploadSpeedToCafes < ActiveRecord::Migration[7.0]
  def change
    add_column :cafes, :upload_speed, :integer, default: 0
    add_column :cafes, :download_speed, :integer, default: 0 
  end
end
