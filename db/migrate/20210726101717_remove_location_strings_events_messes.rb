class RemoveLocationStringsEventsMesses < ActiveRecord::Migration[6.1]
  def change
    remove_column :messes, :location
    remove_column :events, :location
  end
end
