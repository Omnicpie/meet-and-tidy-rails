require "rails_helper"

RSpec.describe Event, type: :model do
  describe "Active Storage" do
    it { should have_many_attached :images }
  end

  describe "#to_s" do
    it "returns its title" do
      expect(Event.new(title: "Locke Park Cleanup").to_s).to eq "Locke Park Cleanup"
    end
  end
end
