# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'

CSV.foreach(Rails.root.join('lib/cafes.csv'), headers: true) do |row|
  next if row['Wifi'].blank?

  @cafe = Cafe.find_by(name: row['Name']) || Cafe.new
  
  @cafe.update!(
    name: row['Name'],
    wifi: row['Wifi'].to_i - 1,
    wifi_name: row['Wifi/Password']&.split('/')&.first,
    wifi_password: row['Wifi/Password']&.split('/')&.last,
    cdmx_wifi: row['CDMX Wifi'],
    coffee: row['Coffee'].to_i - 1,
    plugs: row['Plugs'] == "Yes",
    seating: row['Seating'],
    outdoor: row['Outdoor'],
    food: row['Food'],
    other_people_working: row['Other People Working'],
    calls: row['Calls'],
    overall_rating: row['Overall'].to_i,
    notes: row['Notes'],
    address: row['Address'],
    area: "area_#{row['Area'].downcase.gsub(' ', '_')}".to_sym,
    google_link: row['Map Link'],
    upload_speed: row['Upload Speed'].to_i,
    download_speed: row['Download Speed'].to_i,
    image_link: row['Image Link'],
    calls_rating: row['Calls Rating'],
  )
end