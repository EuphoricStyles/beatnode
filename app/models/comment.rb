class Comment < ActiveRecord::Base
  attr_accessible :body

  belongs_to :commentable, :polymorphic => true

  validates_presence_of :body
  validates_length_of :body, :maximum => 600
end
