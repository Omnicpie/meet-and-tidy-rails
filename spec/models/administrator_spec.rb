require "rails_helper"

RSpec.describe Administrator, type: :model do
  describe "validations" do
    subject { FactoryBot.build(:administrator) }
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe "#to_s" do
    it "returns the administrator's name" do
      expect(Administrator.new(name: "Ian").to_s).to eq "Ian"
    end
  end
end
