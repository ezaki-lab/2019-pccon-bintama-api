class RenamePassColumnToDevices < ActiveRecord::Migration[5.2]
  def change
    rename_column :devices, :pass, :password_digest
  end
end
