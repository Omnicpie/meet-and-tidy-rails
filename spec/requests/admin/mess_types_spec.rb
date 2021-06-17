require "rails_helper"

RSpec.describe "Mess types admin", type: :request do
  before do
    sign_in FactoryBot.create(:administrator)
  end

  describe "GET /admin/mess_types" do
    it "lists all mess_types" do
      FactoryBot.create(:mess_type, name: "Rubbish")
      FactoryBot.create(:mess_type, name: "Fly-tip")

      get "/admin/mess_types"
      expect(response.body).to include("Rubbish")
      expect(response.body).to include("Fly-tip")
    end
  end

  describe "GET /admin/mess_types/new" do
    it "renders a form for a new mess type" do
      get "/admin/mess_types/new"
      assert_select "form[action='#{admin_mess_types_path}']" do
        assert_select("input[type=text][name='mess_type[name]'][required]")
      end
    end
  end

  describe "POST /admin/mess_types" do
    let(:params) do
      {
        name: "Rubbish"
      }
    end

    before do
      post "/admin/mess_types", params: {mess_type: params}
    end

    it "creates a new mess type" do
      mess_type = MessType.last
      expect(mess_type).to be
      expect(mess_type.name).to eq "Rubbish"
    end

    it "redirects to event types index" do
      expect(response).to redirect_to admin_mess_types_path
    end

    it "sets a flash notice" do
      expect(flash[:notice]).to eq "Added new mess type."
    end
  end

  describe "GET /admin/mess_types/:id/edit" do
    let(:mess_type) { FactoryBot.create(:mess_type) }

    it "renders a form to edit the mess type" do
      get "/admin/mess_types/#{mess_type.id}/edit"
      assert_select "form[action='#{admin_mess_type_path(mess_type)}']"
    end

    context "when event type does not exist" do
      it "raises an error" do
        expect { get "/admin/mess_types/1/edit" }
          .to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "PATCH /admin/mess_types/:id" do
    context "with valid params" do
      before do
        @mess_type = FactoryBot.create(
          :mess_type, name: "Fly-tip"
        )
        patch(
          "/admin/mess_types/#{@mess_type.id}",
          params: {
            mess_type: {name: "Rubbish"}
          }
        )
      end

      it "updates the mess type" do
        @mess_type.reload
        expect(@mess_type.name).to eq "Rubbish"
      end

      it "redirects to admin event types path" do
        expect(response).to redirect_to admin_mess_types_path
      end
    end

    context "when mess type does not exist" do
      it "raises an error" do
        expect { patch("/admin/mess_types/1", params: {}) }
          .to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "DELETE /admin/mess_types/:id" do
    context "when mess type exists" do
      let(:mess_type) { FactoryBot.create(:mess_type) }
      before { delete "/admin/mess_types/#{mess_type.id}" }

      it "destroys the mess type" do
        expect(MessType.exists?(mess_type.id)).to be_falsey
      end

      it "redirects to mess types index" do
        expect(response).to redirect_to admin_mess_types_path
      end

      it "sets a flash notice" do
        expect(flash[:notice]).to eq "Mess type deleted."
      end
    end

    context "when mess type does not exist" do
      it "raises an error" do
        expect { delete("/admin/mess_types/1") }
          .to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
