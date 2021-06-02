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

  # event types
    field :event_types, [EventTypeType], null: true do
      description "All event types"
    end

    def event_types
      EventType.all
    end

    field :search_events, [EventType], null: false do
      description "Events matching query"
      argument :query, String, required: true
    end

    def search_events(query:)
      if query.strip.length > 1
        Event.where("title LIKE ?", "%#{query}%").order(starts_at: :desc).limit(100)
      else
        Event.none
      end
    end

  # messes
    field :mess, MessType, null: true do
      description "Find an mess by ID"
      argument :id, ID, required: true
    end

    def mess(id:)
      Mess.find(id)
    end

    field :messes, [MessType], null: true do
      description "All messes"
    end

    def messes
      Mess.all
    end
  end
end
