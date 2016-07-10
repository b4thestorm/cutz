class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.boolean :state
      t.timestamps null: false
    end
  end
end
