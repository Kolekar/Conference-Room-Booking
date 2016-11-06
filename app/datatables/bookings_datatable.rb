require 'application_helper.rb'
class BookingsDatatable
  include ApplicationHelper
  delegate :params, to: :@view

  def initialize(view, user)
    @view = view
    @user = user
  end

  def as_json(_options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: bookings.count,
      iTotalDisplayRecords: bookings.total_count,
      aaData: data
    }
  end

  private

  def data
    bookings.map do |booking|
      [
        booking.room.name,
        booking.user.email,
        booking.start_time,
        booking.end_time,
        booking.waiting_status,
        booking_action(booking)
      ]
    end
  end

  def bookings
    @bookings ||= fetch_bookings
  end

  def fetch_bookings
    @bookings = @user.bookings.includes(:room, :user).all.order("#{sort_column} #{sort_direction}")rescue Booking.where(id: 0)
    @bookings = bookings.page(page).per(per_page) 
    # if params[:search][:value].present?
    #   @bookings = bookings.where("name like :search or location like :search or capacity like :search ", search: "%#{params[:search][:value]}%")
    # end
    @bookings
  end

  def page
    params[:start].to_i / per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    'start_time'
  end

  def sort_direction
    params[:order]['0'][:dir] == 'desc' ? 'asc' : 'desc'
  end
end
