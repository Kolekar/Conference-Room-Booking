class Holiday < ActiveRecord::Base
	validates :date, presence: true
end
