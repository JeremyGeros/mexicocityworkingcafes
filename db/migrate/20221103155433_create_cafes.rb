class CreateCafes < ActiveRecord::Migration[7.0]
  def change
    create_table :cafes do |t|
      t.string :name
      t.integer :wifi
      t.string :wifi_name
      t.string :wifi_password
      t.string :cdmx_wifi
      t.integer :coffee
      t.boolean :plugs
      t.string :seating
      t.string :outdoor
      t.string :food
      t.string :other_people_working
      t.string :calls
      t.integer :overall_rating
      t.text :notes
      t.text :address
      t.integer :area

      t.timestamps
    end
  end
end
