require "rails_helper"

RSpec.describe Api::V1::LandlordsController, type: :controller do
  describe "GET /show" do
    context "when the landlord exists" do
      before(:each) do
        allow(Landlord).to receive(:find).and_return(FactoryBot.build_stubbed(:landlord))
      end

      it "returns http success" do
        get :show, params: {id: "a-uuid"}
        expect(response).to have_http_status(:success)
      end

      it "assigns @landlord" do
        get :show, params: {id: "a-uuid"}
        expect(assigns(:landlord)).to eq(Landlord.find("a-uuid"))
      end
    end

    context "when the landlord does not exist" do
      before(:each) do
        allow(Landlord).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
      end

      it "returns http not found" do
        get :show, params: {id: "a-uuid"}
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns @landlords" do
      get :index
      expect(assigns(:landlords)).to eq(Landlord.all)
    end

    it "returns all landlords" do
      allow(Landlord).to receive(:all).and_return([FactoryBot.build_stubbed(:landlord)])
      get :index
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe "POST /create" do
    context "when successful" do
      it "returns http success" do
        post :create, params: {name: "John Doe"}
        expect(response).to have_http_status(:created)
      end

      it "creates a landlord" do
        expect {
          post :create, params: {name: "John Doe"}
        }.to change { Landlord.count }.by(1)
      end
    end

    context "when unsuccessful" do
      it "returns http unprocessable entity" do
        post :create, params: {name: nil}
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns an error message" do
        post :create, params: {name: nil}
        expect(JSON.parse(response.body)["data"]).to eq(["Name can’t be blank"])
      end

      it "does not create a landlord" do
        expect {
          post :create, params: {name: nil}
        }.to_not change { Landlord.count }
      end
    end
  end

  describe "PUT /update" do
    context "when successful" do
      let(:landlord) { FactoryBot.create(:landlord) }
      let(:landlord_id) { landlord.id }

      it "returns http success" do
        put :update, params: {id: landlord_id, name: "John Doe"}
        expect(response).to have_http_status(:success)
      end

      it "returns the updated landlord" do
        put :update, params: {id: landlord_id, name: "John Doe"}
        expect(JSON.parse(response.body)["data"]["attributes"]["name"]).to eq("John Doe")
      end

      it "updates the landlord" do
        expect {
          put :update, params: {id: landlord_id, name: "John Doe"}
        }.to change { Landlord.find(landlord_id).name }.to("John Doe")
      end
    end

    context "when unsuccessful" do
      context "when the landlord does not exist" do
        let(:landlord_id) { SecureRandom.uuid }

        before(:each) do
          allow(Landlord).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
        end

        it "returns http not found" do
          put :update, params: {id: landlord_id, name: "John Doe"}
          expect {
            Landlord.find(landlord_id)
          }.to raise_error(ActiveRecord::RecordNotFound)

          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

  context "DELETE /destroy" do
    let!(:landlord) { FactoryBot.create(:landlord) }

    context "when successful" do
      it "deletes the landlord" do
        expect {
          delete :destroy, params: {id: landlord.id}
        }.to change { Landlord.count }.by(-1)
      end
    end

    context "when unsuccessful" do
      context "when landlord not found" do
        let(:landlord_id) { SecureRandom.uuid }

        before(:each) do
          allow(Landlord).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
        end

        it "returns 404 not found" do
          delete :destroy, params: {id: landlord_id}
          expect {
            Landlord.find(landlord_id)
          }.to raise_error(ActiveRecord::RecordNotFound)

          expect(response).to have_http_status(:not_found)
        end

        it "doesn't change landlord count" do
          expect {
            delete :destroy, params: {id: landlord_id}
          }.to_not change { Landlord.count }
        end
      end
    end
  end
end
