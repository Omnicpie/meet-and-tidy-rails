class DropMessAndMessType < ActiveRecord::Migration[6.1]
  def change
    drop_table :messes
    drop_table :mess_types
  end
end
