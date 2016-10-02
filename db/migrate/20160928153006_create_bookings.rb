class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :room_id
      t.integer :user_id
      t.datetime :start_time
      t.datetime :end_time
      t.text :invite_email
      t.integer :waiting_status, default: 0

      t.timestamps null: false
    end
  end
end
