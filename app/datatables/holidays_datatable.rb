require 'application_helper.rb'
class HolidaysDatatable
  include ApplicationHelper
  delegate :params, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(_options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: holidays.count,
      iTotalDisplayRecords: holidays.total_count,
      aaData: data
    }
  end

  private

  def data
    holidays.map do |holiday|
      [
        holiday.date,
        holiday.reason,
        holiday_action(holiday)
      ]
    end
  end

  def holidays
    @holidays ||= fetch_holidays
  end

  def fetch_holidays
    @holidays = Holiday.all.order("#{sort_column} #{sort_direction}")
    @holidays = holidays.page(page).per(per_page)
    if params[:search][:value].present?
      @holidays = holidays.where('date like :search or reason like :search ', search: "%#{params[:search][:value]}%")
    end
    @holidays
  end

  def page
    params[:start].to_i / per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    columns = %w(date reason date)
    columns[params[:order]['0'][:column].to_i]
  end

  def sort_direction
    params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
  end
end
