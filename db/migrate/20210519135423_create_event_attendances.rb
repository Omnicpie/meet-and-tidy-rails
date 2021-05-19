class CreateEventAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :event_attendances do |t|
      t.references :user, index: true
      t.references :event, index: true
      t.timestamps
    end
  end
end
