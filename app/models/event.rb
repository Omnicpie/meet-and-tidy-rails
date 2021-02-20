class Event < ApplicationRecord
  include Rails.application.routes.url_helpers

  # Active Storage
  has_many_attached :images

  # Associations
  has_and_belongs_to_many :event_types

  # Validations
  validates_presence_of :title

  def image_urls
    images.map { |img| url_for(img) if img.present? }.compact
  end
end
