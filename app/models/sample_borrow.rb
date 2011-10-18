class SampleBorrow < ActiveRecord::Base
  attr_accessible :sample_id

  belongs_to :sample
  belongs_to :user

  validates_presence_of :sample_id
  validates_presence_of :user_id
end
