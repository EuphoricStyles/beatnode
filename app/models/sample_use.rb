class SampleUse < ActiveRecord::Base
  attr_accessible :sample_id

  belongs_to :beat
  belongs_to :sample

  validates_presence_of :beat_id
  validates_presence_of :sample_id
end
