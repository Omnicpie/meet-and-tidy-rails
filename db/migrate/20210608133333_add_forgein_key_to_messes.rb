class AddForgeinKeyToMesses < ActiveRecord::Migration[6.1]
  def change
    add_column :messes, :mess_type_id, :bigint, null: false
    add_index :messes, :mess_type_id
  end
end
