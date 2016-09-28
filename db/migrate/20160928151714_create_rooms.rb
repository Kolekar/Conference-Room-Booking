class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :location
      t.integer :capacity
      t.string :name

      t.timestamps null: false
    end
  end
end
