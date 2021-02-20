class RenameEventNameToTitle < ActiveRecord::Migration[6.1]
  def change
    rename_column :events, :name, :title
  end
end
