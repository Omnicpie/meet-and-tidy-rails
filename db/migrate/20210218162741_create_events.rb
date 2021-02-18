class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|

      t.string :name, null: false
      t.string :description
      t.datetime :starts_on
      t.string :url

      t.timestamps
    end
  end
end
