class RenameStartsOnToStartsAt < ActiveRecord::Migration[6.1]
  def change
    rename_column :events, :starts_on, :starts_at
  end
end
