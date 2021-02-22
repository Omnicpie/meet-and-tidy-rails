class Facility < ApplicationRecord
  include Rails.application.routes.url_helpers

  # Associations
  has_and_belongs_to_many :events

  # Validations
  validates :name, presence: true, uniqueness: {case_sensitive: false}

  def to_s
    name
  end
end
