class SampleBorrow < ActiveRecord::Base
  attr_accessible :sample_id

  belongs_to :sample
  belongs_to :user
end
