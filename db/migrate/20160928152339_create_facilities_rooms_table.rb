class CreateFacilitiesRoomsTable < ActiveRecord::Migration
  def change
    create_table :facilities_rooms_tables do |t|
      t.integer :facility_id
      t.integer :room_id
    end
  end
end
