require 'rails_helper'

RSpec.describe Api::V1::LandlordsController, type: :controller do
  describe "GET /show" do
    xit "returns http success" do
      get "/api/v1/landlords/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns @landlords' do
      get :index
      expect(assigns(:landlords)).to eq(Landlord.all)
    end

    it "returns all landlords" do
      allow(Landlord).to receive(:all).and_return([FactoryBot.build_stubbed(:landlord)])
      get :index
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end
end
