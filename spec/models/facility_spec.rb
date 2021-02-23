require "rails_helper"

RSpec.describe Facility, type: :model do
  describe "associations" do
    it { should have_and_belong_to_many :events }
  end

  describe "validations" do
    subject { FactoryBot.build :facility }
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe "#to_s" do
    it "returns its name" do
      expect(EventType.new(name: "Disabled access").to_s).to eq "Disabled access"
    end
  end
end
