require "rails_helper"

RSpec.describe Event, type: :model do
  describe "Active Storage" do
    it { should have_many_attached :images }
  end
end
