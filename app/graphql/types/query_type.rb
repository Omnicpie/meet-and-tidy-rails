module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :events, [EventType], null: true do
      description "All events"
    end

    def events
      Event.all
    end

    field :event_types, [EventTypeType], null: true do
      description "All event types"
    end

    def event_types
      EventType.all
    end
  end

end
