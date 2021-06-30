class RenameEventAttendances < ActiveRecord::Migration[6.1]
  def change
    rename_table :event_attendances, :attendances
  end
end
