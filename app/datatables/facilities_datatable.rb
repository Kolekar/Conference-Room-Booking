require 'application_helper.rb'
class FacilitiesDatatable
  include ApplicationHelper
  delegate :params, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(_options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: facilities.count,
      iTotalDisplayRecords: facilities.total_entries,
      aaData: data
    }
  end

  private

  def data
    facilities.map do |facility|
      [
        facility.name,
        facility_action(facility)
      ]
    end
  end

  def facilities
    @facilities ||= fetch_facilities
  end

  def fetch_facilities
    @facilities = Facility.all.order("#{sort_column} #{sort_direction}")
    @facilities = facilities.page(page).per_page(per_page)
    if params[:search][:value].present?
      facilities = facilities.where('name like :search  ', search: "%#{params[:search][:value]}%")
    end
    @facilities
  end

  def page
    params[:start].to_i / per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    'name'
  end

  def sort_direction
    params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
  end
end
