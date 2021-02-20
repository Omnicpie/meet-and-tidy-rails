module Types
  class EventType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :starts_on, GraphQL::Types::ISO8601DateTime, null: true
    field :createded_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :description, String, null: true

    field :event_types, [EventTypeType], null: true

  end
end
