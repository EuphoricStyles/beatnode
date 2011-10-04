class AddTitleToSamples < ActiveRecord::Migration
  def change
    add_column :samples, :title, :string, :null => false
  end
end
