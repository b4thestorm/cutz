class AddCodeToUser < ActiveRecord::Migration
  def change
    add_column :users, :unique_code, :string
  end
end
