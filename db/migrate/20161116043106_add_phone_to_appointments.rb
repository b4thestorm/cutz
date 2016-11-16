class AddPhoneToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :phone, :string
    add_column :appointments, :email, :string
  end
end
