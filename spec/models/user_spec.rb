require "rails_helper"

RSpec.describe User, type: :model do
  describe "Associations" do
    it { should have_many(:attendances) }
    it { should have_many(:events).through(:attendances) }
  end

  describe "Validations" do
    it { should validate_presence_of :name }
  end
end
