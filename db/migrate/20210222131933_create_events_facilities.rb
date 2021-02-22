class CreateEventsFacilities < ActiveRecord::Migration[6.1]
  def change
    create_table :events_facilities do |t|
      t.references :event, index: true
      t.references :facility, index: true

      t.timestamps
    end
  end
end
