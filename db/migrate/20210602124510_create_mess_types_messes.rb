class CreateMessTypesMesses < ActiveRecord::Migration[6.1]
  def change
    create_table :mess_types_messes do |t|
      t.references :mess, index: true
      t.references :mess_type, index: true
      t.timestamps
    end
  end
end
