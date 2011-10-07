class SampleUse < ActiveRecord::Base
  attr_accessible :sample_id

  belongs_to :beat
  belongs_to :sample
end
