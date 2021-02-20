require "rails_helper"

module Mutations
  RSpec.describe CreateAccount, type: :request do
    def query(name:, email:, password:)
      <<~GQL
        mutation {
          createAccount (
            name: "#{name}"
            email: "#{email}"
            password: "#{password}"
          ) {
            errors
          }
        }
      GQL
    end

    it "creates a new user account" do
      post "/graphql", params: {query: query(name: "Ian", email: "ian@example.com", password: "top-secret")}

      expect(User.count).to eq 1
      user = User.last
      expect(user.name).to eq "Ian"
      expect(user.email).to eq "ian@example.com"
      expect(user.valid_password?("top-secret")).to be_truthy
    end
  end
end
