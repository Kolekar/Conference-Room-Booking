class Room < ActiveRecord::Base
  validates :name, :location, :capacity, presence: true
  has_many :bookings
  has_and_belongs_to_many :facilities
end
