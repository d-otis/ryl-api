require 'rails_helper'

RSpec.describe Property, type: :model do
  context "when required attributes are present" do
    it "is valid" do
      expect(FactoryBot.build(:property)).to be_valid
    end
  end

  context "when required attributes are missing" do
    it "is invalid w/o address" do
      expect(FactoryBot.build(:property, address: nil)).to be_invalid
    end
  end

  describe "after_initialize_method" do
    it "initializes the rating @ 0.0" do
      property = Property.new(address: "123 South St")
      expect(property.rating).to eq(0.0)
      expect(property).to be_valid
    end
  end
end
