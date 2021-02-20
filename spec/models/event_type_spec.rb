require "rails_helper"

RSpec.describe EventType, type: :model do
  describe "associations" do
    it { should have_and_belong_to_many :events }
  end

  describe "validations" do
    subject { FactoryBot.build :event_type }
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
