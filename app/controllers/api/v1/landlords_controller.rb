class Api::V1::LandlordsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :landlord_not_found
  before_action :set_landlord, only: [:show, :update, :destroy]

  def show
    render json: serialize_landlord_data(@landlord), status: :ok
  end

  def index
    @landlords = Landlord.all

    render json: serialize_landlord_data(@landlords), status: :ok
  end

  def create
    @landlord = Landlord.new(landlord_params)

    if @landlord.save
      render json: serialize_landlord_data(@landlord), status: :created
    else
      render json: {data: @landlord.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    if @landlord.update(landlord_params)
      render json: serialize_landlord_data(@landlord), status: :ok
    else
      render json: {data: @landlord.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    if @landlord.destroy
      render json: serialize_landlord_data(@landlord), status: :ok
    end
  end

  private

  def landlord_params
    params.permit(:name)
  end

  def set_landlord
    @landlord = Landlord.find(params[:id])
  end

  def landlord_not_found
    render json: {data: "Landlord not found"}, status: :not_found
  end

  def serialize_landlord_data(data)
    LandlordSerializer.new(data).serializable_hash.to_json
  end
end
