class AddGoogleLinkToCafes < ActiveRecord::Migration[7.0]
  def change
    add_column :cafes, :google_link, :string
  end
end
