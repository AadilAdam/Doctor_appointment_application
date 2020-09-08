class ChangeTimeInAppointment < ActiveRecord::Migration[6.0]
  def change
  	rename_column :appointments, :time, :appointment_date
  	change_column :appointments, :appointment_date, :datetime
  	remove_column :appointments, :date
  end
end
