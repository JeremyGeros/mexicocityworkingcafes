class Cafe < ApplicationRecord
  has_one_attached :hero_image do |attachable|
    attachable.variant :thumb, resize: "100x100"
  end

  has_one_attached :speed_test do |attachable|
    attachable.variant :thumb, resize: "100x100"
  end

  has_many_attached :images

  geocoded_by :address

  validates :name, :wifi, presence: true

  enum wifi: {
    wifi_none: 0,
    wifi_bad: 1,
    wifi_good: 2,
  }

  enum coffee: {
    coffee_bad: 0,
    coffee_ok: 1,
    coffee_great: 2,
  }

  enum area: {
    area_none: 0,
    area_roma_norte: 1,
    area_condesa: 2,
    area_polanco: 3,
  }

  def clean_address
    address
      .gsub(/, Cuauhtémoc.+/, '')
  end

  def as_json(options = {})
    json = super(options)
    json[:coffee] = coffee_before_type_cast
    json[:wifi] = wifi_before_type_cast

    ac = ActionController::Base.new
    ac.view_context_class.include(ActionView::Helpers, ApplicationHelper)
    rating_html = ac.render_to_string(partial: "cafes/star_rating", locals: { model: self, field: :overall_rating, size: 5, styling: 'json' })
    json['rating_html'] = rating_html

    json
  end

end
