require "rails_helper"
include FactoryBot::Syntax::Methods

RSpec.describe Landlord, type: :model do
  describe "validations" do
    context "when name is present" do
      it "is valid" do
        expect(build(:landlord)).to be_valid
      end
    end

    context "when name is not present" do
      it "is invalid" do
        expect(build(:landlord, name: nil)).to be_invalid
      end
    end
  end
end
