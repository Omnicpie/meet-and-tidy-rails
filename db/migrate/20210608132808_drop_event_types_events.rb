class DropEventTypesEvents < ActiveRecord::Migration[6.1]
  def change
    drop_table :event_types_events
  end
end
