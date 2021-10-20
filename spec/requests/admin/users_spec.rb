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

  describe "GET /admin/users/new" do
    it "renders a form for a new user" do
      get "/admin/users/new"
      assert_select "form[action='#{admin_users_path}']" do
        # TODO - test inputs
      end
    end
  end

  describe "POST /admin/users" do
    let(:params) do
      {
        email: "alex@example.com",
        name: "Alex",
        password: "secret123"
      }
    end

    before do
      post "/admin/users", params: {user: params}
    end

    it "creates a new user" do
      user = User.last
      expect(user).to be
      expect(user.email).to eq "alex@example.com"
      expect(user.name).to eq "Alex"
    end

    it "redirects to users index" do
      expect(response).to redirect_to admin_users_path
    end

    it "sets a flash notice" do
      expect(flash[:notice]).to eq "Added new user."
    end
  end

  describe "GET /admin/users/:id/edit" do
    let(:user) { FactoryBot.create(:user) }

    it "renders a form to edit the user" do
      get "/admin/users/#{user.id}/edit"
      assert_select "form[action='#{admin_user_path(user)}']"
    end

    context "when user does not exist" do
      it "raises an error" do
        expect { get "/admin/users/1/edit" }
          .to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "PATCH /admin/users/:id" do
    context "with valid params" do
      let(:user) { FactoryBot.create(:user, email: "alex@example.com", name: "Alex") }

      it "updates the user" do
        skip
        patch(
          "/admin/users/#{user.id}",
          params: {
            user: {email: "alexandra@example.com", name: "Alexandra"}
          }
        )
        user.reload
        expect(user.name).to eq "Alexandra"
        expect(user.email).to eq "alexandra@example.com"
      end

      it "redirects to admin users path" do
        patch(
          "/admin/users/#{user.id}",
          params: {
            user: {email: "alexandra@example.com", name: "Alexandra"}
          }
        )
        expect(response).to redirect_to admin_users_path
      end
    end

    context "when user does not exist" do
      it "raises an error" do
        expect { patch("/admin/users/1", params: {}) }
          .to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "DELETE /admin/users/:id" do
    context "when user exists" do
      let(:user) { FactoryBot.create(:user) }
      before { delete "/admin/users/#{user.id}" }

      it "destroys the user" do
        expect(User.exists?(user.id)).to be_falsey
      end

      it "redirects to users index" do
        expect(response).to redirect_to admin_users_path
      end

      it "sets a flash notice" do
        expect(flash[:notice]).to eq "User deleted."
      end
    end

    context "when user does not exist" do
      it "raises an error" do
        expect { delete("/admin/users/1") }
          .to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
