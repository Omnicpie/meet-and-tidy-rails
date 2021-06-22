require "rails_helper"

module Mutations
  RSpec.describe CreateMess, type: :request do
    def query(description:, location:, messTypeId:, title:)
      <<~GQL
        mutation {
          createMess (
            description: "#{description}"
            messTypeId: "#{messTypeId}"
            location: "#{location}"
            title: "#{title}"
          ) {
            errors
          }
        }
      GQL
    end

    it "creates a new mess" do
      mess_type = FactoryBot.create(:mess_type)
      post "/graphql", params: {
        query: query(
          description: "Someone has left loads of rubbish on George Street",
          messTypeId: mess_type.id,
          location: "George Street, Doncaster",
          title: "Rubbish left on George Street",
        )
      }

      expect(Mess.count).to eq 1
      mess = Mess.last
      expect(mess.description).to eq "Someone has left loads of rubbish on George Street"
      expect(mess.mess_type_id).to eq mess_type.id
      expect(mess.location).to eq "George Street, Doncaster"
      expect(mess.title).to eq "Rubbish left on George Street"
    end
  end
end
