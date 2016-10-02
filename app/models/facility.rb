class Facility < ActiveRecord::Base

  has_and_belongs_to_many :rooms
  validates :name, presence: true
end
