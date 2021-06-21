require "rails_helper"

module Mutations
  RSpec.describe CreateEvent, type: :request do
    def query(date:, description:, event_type_id:, location:, title:, url:)
      <<~GQL
        mutation {
          createEvent (
            date: "#{date}"
            description: "#{description}"
            event_type_id: "#{event_type_id}"
            location: "#{location}"
            title: "#{title}"
            url: "#{url}"
          ) {
            errors
          }
        }
      GQL
    end

    it "creates a new event account" do
      post "/graphql", params: {
        query: query(
          date: "2021-07-23",
          description: "An exciting chance to help out our communuty!",
          event_type_id: "Park",
          location: "East park, Hull",
          title: "East Park clean up!",
          url: "www.google.com",
        )
      }

      puts response.status
      puts response.body
      expect(Event.count).to eq 1
      event = Event.last
      expect(event.date).to eq "2021-07-23"
      expect(event.description).to eq "An exciting chance to help out our communuty!"
      expect(event.event_type_id).to eq "Park"
      expect(event.location).to eq "East park, Hull"
      expect(event.title).to eq "East Park clean up!"
      expect(event.url).to eq "www.google.com"
    end
  end
end
