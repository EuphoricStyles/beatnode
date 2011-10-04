class AddDescriptionToBeats < ActiveRecord::Migration
  def change
    add_column :beats, :description, :string
  end
end
