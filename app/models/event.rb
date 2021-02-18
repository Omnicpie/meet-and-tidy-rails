class Event < ApplicationRecord
  include Rails.application.routes.url_helpers

  # Associations
  has_and_belongs_to_many :event_types

  # Validations
  validates_presence_of :name

end
