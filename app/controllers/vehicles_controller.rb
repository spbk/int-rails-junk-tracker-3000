class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[ show update destroy ]

  def index
    @vehicles = Vehicle.includes(:doors, :engine, :advertisements, :seat).all

    render json: @vehicles
  end

  def show
    render json: @vehicle
  end

  def create
    res = CreateVehicleService.create_from_request_params(params.to_unsafe_h)

    if res[:status] == :ok
      @vehicle = res[:vehicle]
      render json: @vehicle, status: :created
    else
      render json: { error: res[:messages] }
    end
  end

  def update
    res = UpdateVehicleService.update_from_request_params(@vehicle, params.to_unsafe_h)

    if res[:status] == :ok
      @vehicle = res[:vehicle]
      render json: @vehicle, status: :ok
    else
      render json: { error: res[:messages] }
    end
  end

  def destroy
    vehicle = Vehicle.find(params[:id])
    vehicle && vehicle.destroy!

    head :no_content
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end
end
