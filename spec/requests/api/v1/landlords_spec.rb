require 'rails_helper'

RSpec.describe "Api::V1::Landlords", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/landlords/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/landlords/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/landlords/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/api/v1/landlords/update"
      expect(response).to have_http_status(:success)
    end
  end

end
