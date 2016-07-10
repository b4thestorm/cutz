class AddUserToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :barber_id, :integer
  end
end
