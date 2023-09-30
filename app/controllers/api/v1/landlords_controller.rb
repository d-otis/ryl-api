class Api::V1::LandlordsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :landlord_not_found

  def show
    @landlord = Landlord.find(params[:id])

    render json: LandlordSerializer.new(@landlord).serializable_hash.to_json
  end

  def index
    @landlords = Landlord.all

    render json: LandlordSerializer.new(@landlords).serializable_hash.to_json
  end

  def create
    @landlord = Landlord.new(landlord_params)

    if @landlord.save
      render json: LandlordSerializer.new(@landlord).serializable_hash.to_json, status: :created
    else
      render json: {data: @landlord.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    # TODO: create a set_landlord method to DRY this up and others using #find
    @landlord = Landlord.find(params[:id])

    if @landlord.update(landlord_params)
      render json: LandlordSerializer.new(@landlord).serializable_hash.to_json, status: :ok
    else
      render json: {data: @landlord.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def landlord_params
    params.permit(:name)
  end

  def landlord_not_found
    render json: {data: 'Landlord not found'}, status: :not_found
  end
end
