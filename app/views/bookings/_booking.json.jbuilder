json.extract! booking, :id, :room_id, :user_id, :start_time, :end_time, :invite_email, :created_at, :updated_at
json.url booking_url(booking, format: :json)
