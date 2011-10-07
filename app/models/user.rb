class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me

  validates_presence_of :username
  validates_uniqueness_of :username, :case_sensitive => false
  validates_length_of :username, :minimum => 4, :maximum => 20
  validates_format_of :username, :with => /^[a-zA-Z0-9_]*[a-zA-Z][a-zA-Z0-9\-_]*$/

  has_many :beats, :dependent => :destroy
  has_many :samples, :dependent => :destroy

  has_many :sample_borrows
  has_many :borrowed_samples, :through => :sample_borrows, :class_name => "Sample", :foreign_key => "sample_id"
end
