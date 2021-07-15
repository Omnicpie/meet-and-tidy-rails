require "rails_helper"

RSpec.describe "admin/users/_form.html.erb", type: :view do
  it "renders a form" do
    user = FactoryBot.build_stubbed(:user)
    assign(:user, user)
    render
    expect(rendered).to include "Name"
    expect(rendered).to include "Email"
    expect(rendered).to include "Password"
    assert_select "form[action='#{admin_users_path}/#{user.id}']"
  end
end
