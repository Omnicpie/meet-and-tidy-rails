module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # events
    field :event, EventType, null: true do
      description "Find an event by ID"
      argument :id, ID, required: true
    end

    def event(id:)
      Event.find(id)
    end

    field :events, [EventType], null: true do
      description "All events"
    end

    def events
      Event.all
    end

    field :search_events, [EventType], null: false do
      description "Events matching query"
      argument :location, String, required: true
      argument :radius, Integer, required: true
      argument :title, String, required: true
    end

    def search_events(location:, radius:, title:)
      if radius == 0
        radius = 200
      end
      if title.strip.length > 1
        Event
          .near(location, radius)
          .where("title LIKE ?", "%#{title}%")
          .order(starts_at: :desc)
          .limit(100)
      else
        Event.none
      end
    end

    # event types
    field :event_type, EventTypeType, null: true do
      description "Find a event type by name"
      argument :id, ID, required: true
    end

    def event_type(id:)
      EventType.find_by(name: "Park")
    end

    field :event_types, [EventTypeType], null: true do
      description "All event types"
    end

    def event_types
      ::EventType.all
    end

    # facilities
    field :facility, FacilityType, null: true do
      description "Find a facility by ID"
      argument :id, ID, required: true
    end

    def facility(id:)
      Facility.find_by(id)
    end

    field :facilities, [FacilityType], null: true do
      description "All facilities"
    end

    def facilities
      Facility.all
    end
  end
end
