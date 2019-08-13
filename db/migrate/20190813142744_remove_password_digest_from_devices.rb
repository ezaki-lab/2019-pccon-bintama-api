class RemovePasswordDigestFromDevices < ActiveRecord::Migration[5.2]
  def up
    remove_column :devices, :password_digest
  end
  def down
    add_column :devices, :password_digest, :string
  end
end
