require "rails_helper"

RSpec.describe "Messes admin", type: :request do
  before do
    sign_in FactoryBot.create(:administrator)
  end

  describe "GET /admin/messes" do
    it "lists all messes" do
      mess_type_1 = FactoryBot.create(:mess_type, name: "Bin bags")
      mess_1 = FactoryBot.create(:mess, title: "Bin bags on George St", mess_type: mess_type_1)

      mess_type_2 = FactoryBot.create(:mess_type, name: "Fly-tip")
      mess_2 = FactoryBot.create(:mess, title: "Fly-tip in alley", mess_type: mess_type_2)

      get "/admin/messes"
      expect(response.body).to include("Bin bags on George St")
      expect(response.body).to include("Fly-tip in alley")
    end
  end

  describe "GET /admin/messes/new" do
    it "renders a form for a new mess" do
      get "/admin/messes/new"
      assert_select "form[action='#{admin_messes_path}']" do
        assert_select("input[type=text][name='mess[title]'][required]")
        assert_select("textarea[name='mess[description]'][required]")
      end
    end
  end

  describe "POST /admin/messes" do
    let!(:mess_type) { FactoryBot.create(:mess_type) }

    let(:params) do
      {
        description: "Someone has left lots of bags of rubbish on the street",
        title: "Bin bags on George St",
        mess_type_id: mess_type.id,
      }
    end

    before do
      post "/admin/messes", params: {mess: params}
    end

    it "creates a new mess" do
      mess = Mess.last
      expect(mess).to be
      expect(mess.description).to eq "Someone has left lots of bags of rubbish on the street"
      expect(mess.title).to eq "Bin bags on George St"
    end

    it "redirects to messes index" do
      expect(response).to redirect_to admin_messes_path
    end

    it "sets a flash notice" do
      expect(flash[:notice]).to eq "Added new mess."
    end
  end

  describe "GET /admin/messes/:id/edit" do
    let(:mess_type) { FactoryBot.create(:mess_type) }
    let(:mess_type_id) { mess_type.id }
    let(:mess) { FactoryBot.create(:mess, mess_type: mess_type) }

    it "renders a form to edit the mess" do
      get "/admin/messes/#{mess.id}/edit"
      assert_select "form[action='#{admin_mess_path(mess)}']"
    end

    context "when mess does not exist" do
      it "raises an error" do
        expect { get "/admin/messes/1/edit" }
          .to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "PATCH /admin/messes/:id" do
    context "with valid params" do
      before do
        mess_type = FactoryBot.create(:mess_type)

        @mess = FactoryBot.create(
          :mess, description: "Old desc", title: "Bin bags on Smith Lane", mess_type_id: mess_type.id,
        )
        patch(
          "/admin/messes/#{@mess.id}",
          params: {
            mess: {description: "New desc", title: "Bottles on Cleethorpes beach", mess_type_id: mess_type.id}
          }
        )
      end

      it "updates the mess" do
        @mess.reload
        expect(@mess.description).to eq "New desc"
        expect(@mess.title).to eq "Bottles on Cleethorpes beach"
      end

      it "redirects to admin messes path" do
        expect(response).to redirect_to admin_messes_path
      end
    end

    context "when mess does not exist" do
      it "raises an error" do
        expect { patch("/admin/messes/1", params: {}) }
          .to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "DELETE /admin/messes/:id" do
    context "when mess exists" do
      let(:mess_type) { FactoryBot.create(:mess_type) }
      let(:mess_type_id) { mess_type.id }
      let(:mess) { FactoryBot.create(:mess, mess_type: mess_type) }
      before { delete "/admin/messes/#{mess.id}" }

      it "destroys the mess" do
        expect(Mess.exists?(mess.id)).to be_falsey
      end

      it "redirects to messes index" do
        expect(response).to redirect_to admin_messes_path
      end

      it "sets a flash notice" do
        expect(flash[:notice]).to eq "Mess deleted."
      end
    end

    context "when mess does not exist" do
      it "raises an error" do
        expect { delete("/admin/messes/1") }
          .to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
