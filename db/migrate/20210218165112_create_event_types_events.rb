class CreateEventTypesEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :event_types_events do |t|
      t.references :event, index: true
      t.references :event_type, index: true

      t.timestamps
    end
  end
end
