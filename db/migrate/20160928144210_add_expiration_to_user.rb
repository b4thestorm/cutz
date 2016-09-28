class AddExpirationToUser < ActiveRecord::Migration
  def change
    add_column :users, :expiration, :integer
  end
end
