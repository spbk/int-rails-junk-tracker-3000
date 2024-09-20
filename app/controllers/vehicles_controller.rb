class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[ show edit update destroy ]

  # GET /vehicles or /vehicles.json
  def index
    @vehicles = Vehicle.all
  end

  # GET /vehicles/1 or /vehicles/1.json
  def show
    @vehicle = Vehicle.find(params["id"])
  end

  # GET /vehicles/new
  def new
    @vehicle = Vehicle.new
  end

  # GET /vehicles/1/edit
  def edit
  end

  # POST /vehicles or /vehicles.json
  def create
    res = CreateVehicleService.create_from_request_params(params)

    respond_to do |format|
      if res[:status] == :ok
        @vehicle = res[:vehicle]

        format.html do
          Rails.logger.info("in HTML")

          redirect_to "/vehicles/#{@vehicle.id}", notice: "Vehicle was successfully created."
        end

        format.json do
          Rails.logger.info("in JSON")
          render :show, status: :created, location: "/vehicles/#{@vehicle.id}"
        end

      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: res[:messages], status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicles/1 or /vehicles/1.json
  def update
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.html { redirect_to @vehicle, notice: "Vehicle was successfully updated." }
        format.json { render :show, status: :ok, location: @vehicle }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicles/1 or /vehicles/1.json
  def destroy
    @vehicle.destroy
    head :no_content
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end
end
