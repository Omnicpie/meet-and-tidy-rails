class Mess < ApplicationRecord
  include Rails.application.routes.url_helpers

  # Active Storage
  has_many_attached :images

  # Validations
  validates_presence_of :name

  def to_s
    name
  end

  def image_urls
    images.map { |img| url_for(img) if img.present? }.compact
  end
end
