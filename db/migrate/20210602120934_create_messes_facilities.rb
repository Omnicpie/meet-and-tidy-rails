class CreateMessesFacilities < ActiveRecord::Migration[6.1]
  def change
    create_table :messes_facilities do |t|
      t.references :mess, index: true
      t.references :facility, index: true
      t.timestamps
    end
  end
end
