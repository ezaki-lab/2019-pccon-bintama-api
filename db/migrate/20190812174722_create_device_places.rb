class CreateDevicePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :device_places do |t|
      t.integer :device_id
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
