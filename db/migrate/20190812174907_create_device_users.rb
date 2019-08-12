class CreateDeviceUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :device_users do |t|
      t.integer :device_id
      t.string :user_id

      t.timestamps
    end
  end
end
