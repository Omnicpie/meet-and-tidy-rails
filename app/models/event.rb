class Event < ApplicationRecord
  include Rails.application.routes.url_helpers

  # Active Storage
  has_many_attached :images

  # Associations
  belongs_to :event_type
  has_and_belongs_to_many :facilities
  has_many :attendances
  has_many :users, through: :attendances

  # Geocoder
  geocoded_by :formatted_location
  after_validation :geocode

  # Validations
  validates_presence_of :location
  validates_presence_of :title

  def formatted_location
    "#{location}, UK"
  end

  def to_s
    title
  end

  def image_urls
    # images.map { |img| url_for(img) if img.present? }.compact
    images.map { |img| rails_blob_path(img, only_path: true) if img.present? }.compact
  end
end
