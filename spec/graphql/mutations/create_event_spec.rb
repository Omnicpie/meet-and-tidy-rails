require "rails_helper"

module Mutations
  RSpec.describe CreateEvent, type: :request do
    def query(date:, description:, eventTypeId:, facilityId:, location:, title:, url:)
      <<~GQL
        mutation {
          createEvent (
            date: "#{date}"
            description: "#{description}"
            eventTypeId: "#{eventTypeId}"
            facilityId: "#{facilityId}"
            location: "#{location}"
            title: "#{title}"
            url: "#{url}"
          ) {
            errors
          }
        }
      GQL
    end

    it "creates a new event" do
      event_type = FactoryBot.create(:event_type)
      facility = FactoryBot.create(:facility)
      post "/graphql", params: {
        query: query(
          date: "2021-07-23",
          description: "An exciting chance to help out our communuty!",
          eventTypeId: event_type.id,
          facilityId: facility.id,
          location: "East park, Hull",
          title: "East Park clean up!",
          url: "www.google.com",
        )
      }

      expect(Event.count).to eq 1
      event = Event.last
      expect(event.date).to eq "2021-07-23"
      expect(event.description).to eq "An exciting chance to help out our communuty!"
      expect(event.event_type_id).to eq event_type.id
      expect(event.facility_id).to eq facility.id
      expect(event.location).to eq "East park, Hull"
      expect(event.title).to eq "East Park clean up!"
      expect(event.url).to eq "www.google.com"
    end
  end
end
