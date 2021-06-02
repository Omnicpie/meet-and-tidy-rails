class RenameMessNameToTitle < ActiveRecord::Migration[6.1]
  def change
    rename_column :messes, :name, :title
  end
end
