class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy, :cancel_bookin]
  load_and_authorize_resource
  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = begin
                  current_user.bookings
                rescue
                  []
                end
    respond_to do |format|
      format.html
      format.json { render json: BookingsDatatable.new(view_context, current_user) }
    end
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
    @url = room_bookings_path(params[:room_id])
  end

  # GET /bookings/1/edit
  def edit
    @url = room_bookings_path(params[:room_id], @booking)
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params.merge(user_id: current_user.id, room_id: params[:room_id]))
    @url = room_bookings_path(params[:room_id])
    respond_to do |format|
      if @booking.save
        format.html { redirect_to room_path(params[:room_id]), notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params.merge(user_id: current_user.id, room_id: params[:room_id]))
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def cancel_booking
    @booking.canceled! if can? :update, Booking
    redirect_to root_path
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_booking
    @booking = Booking.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def booking_params
    params.require(:booking).permit(:start_time, :end_time, :invite_email)
  end
end
