module ApplicationHelper
  def room_action(room)
    m = "<a href = '/rooms/#{room.id}'> Show </a> "
    m += "<a href = '/rooms/#{room.id}/edit'> Edit </a> " if @view.can? :edit, room
    m += "<a href='/rooms/#{room.id}' data-method='delete' data-confirm='Are you sure?'> Destroy </a>  " if @view.can? :destroy, room
    m
  end

  def holiday_action(holiday)
    m = ''
    m += "<a href = '/holidays/#{holiday.id}/edit'> Edit </a> " if @view.can? :edit, holiday
    m += "<a href='/holidays/#{holiday.id}' data-method='delete' data-confirm='Are you sure?'> Destroy </a>  " if @view.can? :destroy, holiday
    m
  end

  def booking_action(booking)
    m = ''
    m += "<a href='/cancel_booking/#{booking.id}' data-confirm='Are you sure?'> Cancel </a>  " unless booking.canceled?
    m
  end

  def facility_action(facility)
    m = ''
    m += "<a href = '/facilities/#{facility.id}/edit'> Edit </a> " if @view.can? :edit, facility
    m += "<a href='/facilities/#{facility.id}' data-method='delete' data-confirm='Are you sure?'> Destroy </a>  " if @view.can? :destroy, facility
    m
  end
end
