module Types
  class EventType < Types::BaseObject
    field :description, String, null: true
    field :id, ID, null: false
    field :title, String, null: false
    field :url, String, null: true
    field :starts_at, GraphQL::Types::ISO8601DateTime, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :attendances, [AttendanceType], null: false
    field :event_type, [EventTypeType], null: true
    field :facilities, [FacilityType], null: true
    field :image_urls, [String], null: true
  end
end

