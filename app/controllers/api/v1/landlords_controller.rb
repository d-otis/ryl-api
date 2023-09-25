class Api::V1::LandlordsController < ApplicationController
  def show
    @landlord = Landlord.find(params[:id])

    render json: LandlordSerializer.new(@landlord).serializable_hash.to_json
  rescue ActiveRecord::RecordNotFound
    render json: {data: 'Landlord not found'}, status: :not_found
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
  end

  private

  def landlord_params
    params.permit(:name)
  end
end
