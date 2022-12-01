class AddCallsRatingToCafes < ActiveRecord::Migration[7.0]
  def change
    add_column :cafes, :calls_rating, :integer, default: 0
  end
end
