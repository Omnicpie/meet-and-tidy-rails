class AddAttendingToEventAttendances < ActiveRecord::Migration[6.1]
  def change
    add_column :event_attendances, :attending, :boolean, default: false, null: false
  end
end
