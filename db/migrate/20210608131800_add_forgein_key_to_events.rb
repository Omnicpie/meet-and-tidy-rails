class AddForgeinKeyToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :event_type_id, :bigint, null: false
    add_index :events, :event_type_id
  end
end
