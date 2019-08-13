class RenamePassColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :pass, :password_digest
  end
end
