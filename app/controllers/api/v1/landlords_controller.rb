class Api::V1::LandlordsController < ApplicationController
  def show
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
