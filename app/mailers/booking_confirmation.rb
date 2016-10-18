class BookingConfirmation < ApplicationMailer
  def booking_confirmation(booking)
    @booking = booking
    @user = booking.user
    mail(to: @user.email, subject: 'Booking Confirmation')
  end

  def booking_cancellation(booking)
    @booking = booking
    @user = booking.user
    mail(to: @user.email, subject: 'Booking Cancellation')
  end
end
