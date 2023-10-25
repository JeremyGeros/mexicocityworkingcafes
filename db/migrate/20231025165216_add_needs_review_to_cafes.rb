class AddNeedsReviewToCafes < ActiveRecord::Migration[7.0]
  def change
    add_column :cafes, :needs_review, :boolean, default: false, null: true
  end
end
