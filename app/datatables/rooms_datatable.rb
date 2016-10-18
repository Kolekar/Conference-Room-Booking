require 'application_helper.rb'
class RoomsDatatable
  include ApplicationHelper
  delegate :params, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(_options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: rooms.count,
      iTotalDisplayRecords: rooms.total_count,
      aaData: data
    }
  end

  private

  def data
    rooms.map do |room|
      [
        room.location,
        room.capacity,
        room.name,
        room.facilities.collect(&:name).join(', '),
        room_action(room)
      ]
    end
  end

  def rooms
    @rooms ||= fetch_rooms
  end

  def fetch_rooms
    rooms = Room.all.order("#{sort_column} #{sort_direction}")
    rooms = rooms.page(page).per(per_page)
    if params[:search][:value].present?
      rooms = rooms.where('name like :search or location like :search or capacity like :search ', search: "%#{params[:search][:value]}%")
    end
    rooms
  end

  def page
    params[:start].to_i / per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    columns = %w(location capacity name name name)
    columns[params[:order]['0'][:column].to_i]
  end

  def sort_direction
    params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
  end
end
