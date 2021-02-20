require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    subject { FactoryBot.build(:user) }
    it { should validate_presence_of :name }
  end
end
