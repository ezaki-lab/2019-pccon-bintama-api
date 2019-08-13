class AddUrlToDevice < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :url, :string
  end
end
