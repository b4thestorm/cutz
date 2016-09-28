class AddCronofyTokentoUsers < ActiveRecord::Migration
  def change
    add_column :users, :cronofy_access_token, :string
    add_column :users, :cronofy_refresh_token, :string
  end
end
