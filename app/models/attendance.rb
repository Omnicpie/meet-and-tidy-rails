class Attendance < ApplicationRecord
  include Rails.application.routes.url_helpers

  # Associations
  belongs_to :event
  belongs_to :user

end
