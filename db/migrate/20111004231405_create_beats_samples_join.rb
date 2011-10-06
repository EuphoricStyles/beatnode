class CreateBeatsSamplesJoin < ActiveRecord::Migration
  def up
    create_table 'beats_samples', :id => false do |t|
      t.references :beat, :null => false
      t.references :sample, :null => false
    end

    add_index 'beats_samples', [ :beat_id, :sample_id ]
  end

  def down
    drop_table 'beats_samples'
  end
end
