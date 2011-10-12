class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :bio, :password, :password_confirmation, :remember_me

  # devise takes care of email validations
  validates_presence_of :username
  validates_uniqueness_of :username, :case_sensitive => false
  validates_length_of :username, :minimum => 4, :maximum => 20
  validates_format_of :username, :with => /^[a-zA-Z0-9_]*[a-zA-Z][a-zA-Z0-9\-_]*$/

  validates_length_of :bio, :maximum => 600

  has_many :beats, :dependent => :destroy
  has_many :samples, :dependent => :destroy

  has_many :sample_borrows
  has_many :borrowed_samples, :through => :sample_borrows, :source => :sample

  def borrow! sample
    self.sample_borrows.create!(:sample_id => sample.id)
  end

  def unborrow! sample
    self.sample_borrows.find_by_sample_id(sample.id).destroy
  end

  def borrowing? sample
    !!self.sample_borrows.find_by_sample_id(sample.id)
  end
end
