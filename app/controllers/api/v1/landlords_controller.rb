class Api::V1::LandlordsController < ApplicationController
  def show
    @landlord = Landlord.find(params[:id])

    render json: LandlordSerializer.new(@landlord).serializable_hash.to_json
  end

  def index
    @landlords = Landlord.all

    render json: LandlordSerializer.new(@landlords).serializable_hash.to_json
  end

  def create
  end

  def update
  end
end
