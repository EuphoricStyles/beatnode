class RemoveNameFromSamples < ActiveRecord::Migration
  def up
    remove_column :samples, :name
  end

  def down
    add_column :samples, :name, :string
  end
end
