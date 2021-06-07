require "rails_helper"

RSpec.describe Mess, type: :model do
  describe "Active Storage" do
    it { should have_many_attached :images }
  end

  describe "#to_s" do
    it "returns its title" do
      expect(Mess.new(title: "George Street mess").to_s).to eq "George Street mess"
    end
  end
end
