require "rails_helper"

RSpec.describe "Event types admin", type: :request do
  before do
    sign_in FactoryBot.create(:administrator)
  end

  describe "GET /admin/event_types" do
    it "lists all event_types" do
      FactoryBot.create(:event_type, name: "Beach")
      FactoryBot.create(:event_type, name: "Park")

      get "/admin/event_types"
      expect(response.body).to include("Beach")
      expect(response.body).to include("Park")
    end
  end

  describe "GET /admin/event_types/new" do
    it "renders a form for a new event type" do
      get "/admin/event_types/new"
      assert_select "form[action='#{admin_event_types_path}']" do
        assert_select("input[type=text][name='event_type[name]'][required]")
      end
    end
  end

  describe "POST /admin/event_types" do
    let(:params) do
      {
        name: "Park"
      }
    end

    before do
      post "/admin/event_types", params: {event_type: params}
    end

    it "creates a new event_type" do
      event_type = EventType.last
      expect(event_type).to be
      expect(event_type.name).to eq "Park"
    end

    it "redirects to event types index" do
      expect(response).to redirect_to admin_event_types_path
    end

    it "sets a flash notice" do
      expect(flash[:notice]).to eq "Added new event type."
    end
  end

  describe "GET /admin/event_types/:id/edit" do
    let(:event_type) { FactoryBot.create(:event_type) }

    it "renders a form to edit the event type" do
      get "/admin/event_types/#{event_type.id}/edit"
      assert_select "form[action='#{admin_event_type_path(event_type)}']"
    end
  end

  describe "PATCH /admin/event_types/:id" do
    context "with valid params" do
      before do
        @event_type = FactoryBot.create(
          :event_type, name: "Cemetery"
        )
        patch(
          "/admin/event_types/#{@event_type.id}",
          params: {
            event_type: {name: "Park"}
          }
        )
      end

      it "updates the event_type" do
        @event_type.reload
        expect(@event_type.name).to eq "Park"
      end

      it "redirects to admin event types path" do
        expect(response).to redirect_to admin_event_types_path
      end
    end
  end

  describe "DELETE /admin/event_types/:id" do
    let(:event_type) { FactoryBot.create(:event_type) }
    before { delete "/admin/event_types/#{event_type.id}" }

    it "destroys the event type" do
      expect(EventType.exists?(event_type.id)).to be_falsey
    end

    it "redirects to event types index" do
      expect(response).to redirect_to admin_event_types_path
    end

    it "sets a flash notice" do
      expect(flash[:notice]).to eq "Event type deleted."
    end
  end
end
