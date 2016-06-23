class AddFieldsToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :start_time, :datetime 
    add_column :appointments, :end_time, :datetime
    add_column :appointments, :summary, :string 
    add_column :appointments, :description, :string 
    add_column :appointments, :location, :string
  end
end
