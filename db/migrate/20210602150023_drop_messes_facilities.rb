class DropMessesFacilities < ActiveRecord::Migration[6.1]
  def change
    drop_table :messes_facilities
  end
end
