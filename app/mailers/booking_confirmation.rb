class BookingConfirmation < ApplicationMailer
	default from: "postmaster@sandboxd52c431ea3874aaf801a9564a9cf64ad.mailgun.org"
	def booking_confirmation(user)
	  @user = user
	  mail(to: @user.email, subject: 'Booking Confirmation')
	end

	def booking_cancellation(user)
	  @user = user
	  mail(to: @user.email, subject: 'Booking Cancellation')
	end
end
