require "rails_helper"

RSpec.describe "Facilities admin", type: :request do
  before do
    sign_in FactoryBot.create(:administrator)
  end

  describe "GET /admin/facilities" do
    it "lists all facilities" do
      FactoryBot.create(:facility, name: "Toilets")
      FactoryBot.create(:facility, name: "Parking")

      get "/admin/facilities"
      expect(response.body).to include("Toilets")
      expect(response.body).to include("Parking")
    end
  end

  describe "GET /admin/facilities/new" do
    it "renders a form for a new facility" do
      get "/admin/facilities/new"
      assert_select "form[action='#{admin_facilities_path}']" do
        assert_select("input[type=text][name='facility[name]'][required]")
      end
    end
  end

  describe "POST /admin/facilities" do
    let(:params) do
      {
        name: "Parking"
      }
    end

    before do
      post "/admin/facilities", params: {facility: params}
    end

    it "creates a new facility" do
      facilities = Facility.last
      expect(facilities).to be
      expect(facilities.name).to eq "Parking"
    end

    it "redirects to facilities index" do
      expect(response).to redirect_to admin_facilities_path
    end

    it "sets a flash notice" do
      expect(flash[:notice]).to eq "Added new facility."
    end
  end

  describe "GET /admin/facilities/:id/edit" do
    let(:facility) { FactoryBot.create(:facility) }

    it "renders a form to edit the facility" do
      get "/admin/facilities/#{facility.id}/edit"
      assert_select "form[action='#{admin_facility_path(facility)}']"
    end

    context "when facility does not exist" do
      it "raises an error" do
        expect { get "/admin/facilities/1/edit" }
          .to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "PATCH /admin/facilities/:id" do
    context "with valid params" do
      before do
        @facilities = FactoryBot.create(
          :facility, name: "Toilets"
        )
        patch(
          "/admin/facilities/#{@facilities.id}",
          params: {
            facility: {name: "Parking"}
          }
        )
      end

      it "updates the facility" do
        @facilities.reload
        expect(@facilities.name).to eq "Parking"
      end

      it "redirects to admin facilities path" do
        expect(response).to redirect_to admin_facilities_path
      end
    end

    context "when facility does not exist" do
      it "raises an error" do
        expect { patch("/admin/facilities/1", params: {}) }
          .to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "DELETE /admin/facilities/:id" do
    context "when facility exists" do
      let(:facility) { FactoryBot.create(:facility) }
      before { delete "/admin/facilities/#{facility.id}" }

      it "destroys the facility" do
        expect(Facility.exists?(facility.id)).to be_falsey
      end

      it "redirects to facilities index" do
        expect(response).to redirect_to admin_facilities_path
      end

      it "sets a flash notice" do
        expect(flash[:notice]).to eq "Facility deleted."
      end
    end

    context "when facility does not exist" do
      it "raises an error" do
        expect { delete("/admin/facilities/1") }
          .to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
