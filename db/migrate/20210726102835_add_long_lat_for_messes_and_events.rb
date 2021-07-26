class AddLongLatForMessesAndEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :messes, :latitude, :float
    add_column :messes, :longitude, :float
    add_column :messes, :location, :text
    add_column :events, :latitude, :float
    add_column :events, :longitude, :float
    add_column :events, :location, :text
  end
end
