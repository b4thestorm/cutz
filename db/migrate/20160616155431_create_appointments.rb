class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :schedule_day
      t.datetime :schdule_time
      t.integer :barber_id
      t.timestamps null: false
    end
  end
end
