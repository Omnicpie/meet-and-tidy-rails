module Types
  class AttendanceType < Types::BaseObject
    field :event_id, ID, null: false
    field :user_id, ID, null: false
  end
end
