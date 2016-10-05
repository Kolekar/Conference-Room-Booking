class Booking < ActiveRecord::Base
  belongs_to :room
  belongs_to :user
  validate :validate_holiday, :validate_weak_end, :validate_same_date
  validates :room_id, :user_id, :start_time, :end_time, presence: true
  after_create :set_avalablity
  after_update :set_status
  enum waiting_status: [:booked, :waiting, :canceled]

  def validate_weak_end
    errors[:base] << 'Its Weak End' if weak_end?
  end

  def weak_end?
    start_time_day = start_time.strftime('%A')
    start_time_day == 'Saturday' || start_time_day == 'Sunday'
  end

  def validate_holiday
    errors[:base] << 'Its Holiday' if Holiday.find_by(date: start_time.to_date)
  end

  def set_avalablity
    waiting! unless check_avalablity(start_time, end_time).blank?
    send_booking_mail(self)
  end

  def set_status
    return unless canceled?
    send_booking_mail(self)
    bookings = Booking.where('id != ? and room_id = ? and waiting_status = ? and start_time > ? and end_time < ?', id, room_id, 1, start_time.beginning_of_day, start_time.end_of_day).order(:created_at)
    bookings.each do |booking|
      next unless check_avalablity(booking.start_time, booking.end_time).blank?
      booking.booked!
      send_booking_mail(booking)
      break
    end
  end

  def send_booking_mail(booking)
    BookingConfirmation.booking_confirmation(booking).deliver_later && return unless booking.canceled?
    BookingConfirmation.booking_cancellation(booking).deliver_later
  end

  def check_avalablity(start_time, end_time)
    Booking.where('waiting_status = ? and ((start_time > ? and start_time < ?) or (end_time > ? and end_time < ?) or (start_time < ? and end_time > ?))', 0, start_time, end_time, start_time, end_time, start_time, end_time)
  end

  def validate_same_date
    errors[:base] << 'Please book for one day' unless start_time.to_date == end_time.to_date
    errors[:base] << 'Start time mustg be less than End Time' unless start_time < end_time
  end
end
