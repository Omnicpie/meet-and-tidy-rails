require "rails_helper"

RSpec.describe "Users admin", type: :request do
  before do
    sign_in FactoryBot.create(:administrator)
  end

  describe "GET /admin/users" do
    it "lists all users" do
      FactoryBot.create(:user, name: "Summer", email: "summer@example.com")
      FactoryBot.create(:user, name: "Rick", email: "rick@example.com")

      get "/admin/users"
      expect(response.body).to include("Summer")
      expect(response.body).to include("summer@example.com")
      expect(response.body).to include("Rick")
      expect(response.body).to include("rick@example.com")
    end
  end
end
