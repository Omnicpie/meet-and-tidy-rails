class CreateMesses < ActiveRecord::Migration[6.1]
  def change
    create_table :messes do |t|
      t.string :name, null: false
      t.string :description
      t.string :location
      t.timestamps
    end
  end
end
