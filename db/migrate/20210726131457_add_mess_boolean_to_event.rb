class AddMessBooleanToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :mess, :boolean, default: false, null: false
  end
end
