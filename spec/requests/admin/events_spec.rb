require "rails_helper"

RSpec.describe "Events admin", type: :request do
  before do
    sign_in FactoryBot.create(:administrator)
  end

  describe "GET /admin/events" do
    it "lists all events" do
      event_type_1 = FactoryBot.create(:event_type, name: "Park")
      FactoryBot.create(:event, title: "Locke Park Cleanup", event_type: event_type_1, location: "Sheffield, UK")

      event_type_2 = FactoryBot.create(:event_type, name: "Beach")
      FactoryBot.create(:event, title: "Cleethorpes Beach Cleanup", event_type: event_type_2, location: "Rotherham, UK")

      get "/admin/events"
      expect(response.body).to include("Locke Park Cleanup")
      expect(response.body).to include("Cleethorpes Beach Cleanup")
    end
  end

  describe "GET /admin/events/new" do
    it "renders a form for a new event" do
      get "/admin/events/new"
      assert_select "form[action='#{admin_events_path}']" do
        assert_select("input[type=text][name='event[title]'][required]")
        assert_select("textarea[name='event[description]'][required]")
        assert_select("input[type=url][name='event[url]']")
      end
    end
  end

  describe "POST /admin/events" do
    let!(:event_type) { FactoryBot.create(:event_type) }

    let(:params) do
      {
        description: "Lots of litter",
        title: "Copley Road Litterpick",
        url: "https://friendsofcopleyroad.example.org",
        location: "York, UK",
        event_type_id: event_type.id
      }
    end

    before do
      post "/admin/events", params: {event: params}
    end

    it "creates a new event" do
      event = Event.last
      expect(event).to be
      expect(event.description).to eq "Lots of litter"
      expect(event.title).to eq "Copley Road Litterpick"
      expect(event.location).to eq "York, UK"
      expect(event.url).to eq "https://friendsofcopleyroad.example.org"
    end

    it "redirects to events index" do
      expect(response).to redirect_to admin_events_path
    end

    it "sets a flash notice" do
      expect(flash[:notice]).to eq "Added new event."
    end
  end

  describe "GET /admin/events/:id/edit" do
    let(:event_type) { FactoryBot.create(:event_type) }
    let(:event_type_id) { event_type.id }
    let(:event) { FactoryBot.create(:event, event_type: event_type) }

    it "renders a form to edit the event" do
      get "/admin/events/#{event.id}/edit"
      assert_select "form[action='#{admin_event_path(event)}']"
    end

    context "when event does not exist" do
      it "raises an error" do
        expect { get "/admin/events/1/edit" }
          .to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "PATCH /admin/events/:id" do
    context "with valid params" do
      before do
        event_type = FactoryBot.create(:event_type)

        @event = FactoryBot.create(
          :event, description: "Old desc", title: "Locke Park Cleanup", event_type_id: event_type.id
        )
        patch(
          "/admin/events/#{@event.id}",
          params: {
            event: {description: "New desc", title: "Cleethorpes Beach Cleanup", event_type_id: event_type.id}
          }
        )
      end

      it "updates the event" do
        @event.reload
        expect(@event.description).to eq "New desc"
        expect(@event.title).to eq "Cleethorpes Beach Cleanup"
      end

      it "redirects to admin events path" do
        expect(response).to redirect_to admin_events_path
      end
    end

    context "when event does not exist" do
      it "raises an error" do
        expect { patch("/admin/events/1", params: {}) }
          .to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "DELETE /admin/events/:id" do
    context "when event exists" do
      let(:event_type) { FactoryBot.create(:event_type) }
      let(:event_type_id) { event_type.id }
      let(:event) { FactoryBot.create(:event, event_type: event_type) }
      before { delete "/admin/events/#{event.id}" }

      it "destroys the event" do
        expect(Event.exists?(event.id)).to be_falsey
      end

      it "redirects to events index" do
        expect(response).to redirect_to admin_events_path
      end

      it "sets a flash notice" do
        expect(flash[:notice]).to eq "Event deleted."
      end
    end

    context "when event does not exist" do
      it "raises an error" do
        expect { delete("/admin/events/1") }
          .to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
