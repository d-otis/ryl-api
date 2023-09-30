class Api::V1::LandlordsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :landlord_not_found
  before_action :set_landlord, only: [:show, :update, :destroy]

  def show
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
    if @landlord.update(landlord_params)
      render json: LandlordSerializer.new(@landlord).serializable_hash.to_json, status: :ok
    else
      render json: {data: @landlord.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    if @landlord.destroy
      render json: LandlordSerializer.new(@landlord).serializable_hash.to_json, status: :ok
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
    render json: {data: 'Landlord not found'}, status: :not_found
  end
end
