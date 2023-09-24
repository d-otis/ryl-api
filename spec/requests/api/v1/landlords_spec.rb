require 'rails_helper'

RSpec.describe Api::V1::LandlordsController, type: :controller do
  describe "GET /show" do
    it "returns http success" do
      allow(Landlord).to receive(:find).and_return(FactoryBot.build_stubbed(:landlord))
      
      get :show, params: { id: 'a-uuid' }
      expect(response).to have_http_status(:success)
      expect(assigns(:landlord)).to eq(Landlord.find('a-uuid'))
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
