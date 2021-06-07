require "rails_helper"

RSpec.describe MessType, type: :model do
  describe "associations" do
    it { should have_and_belong_to_many :messes }
  end

  describe "validations" do
    subject { FactoryBot.build :mess_type }
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe "#to_s" do
    it "returns its name" do
      expect(MessType.new(name: "Stree").to_s).to eq "Stree"
    end
  end
end
