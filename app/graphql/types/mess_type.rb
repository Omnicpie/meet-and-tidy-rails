module Types
  class MessType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :location, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :description, String, null: true

    field :image_urls, [String], null: true
  end
end
