class DropMessTypesMesses < ActiveRecord::Migration[6.1]
  def change
    drop_table :mess_types_messes
  end
end
