class CreateMessTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :mess_types do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
