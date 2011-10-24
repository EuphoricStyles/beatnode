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

  # beats and samples uploaded by the user
  has_many :beats, :dependent => :destroy
  has_many :samples, :dependent => :destroy

  # samples taken from other users (like forking in github kinda)
  has_many :sample_borrows, :dependent => :destroy
  has_many :borrowed_samples, :through => :sample_borrows, :source => :sample

  # user watches other users
  has_many :user_relationships, :foreign_key => 'watcher_id', :dependent => :destroy
  has_many :watching, :through => :user_relationships, :source => 'watched_id'

  # user is watched by other users
  has_many :reverse_user_relationships, :foreign_key => 'watched_id', :class_name => 'UserRelationship'
  has_many :watchers, :through => :reverse_user_relationships

  def watch!(user)
    user_relationships.create!(:watched_id => user.id)
  end

  def unwatch!(user)
    user_relationships.find_by_watched_id(user.id).destroy
  end

  def watching?(user)
    !!user_relationships.find_by_watched_id(user.id)
  end

  def borrow!(sample)
    sample_borrows.create!(:sample_id => sample.id) unless samples.include?(sample)
  end

  def unborrow!(sample)
    sample_borrows.find_by_sample_id(sample.id).destroy if borrowing?(sample)
  end

  def borrowing?(sample)
    !!sample_borrows.find_by_sample_id(sample.id)
  end

  def own?(audio)
    if audio.is_a?(Sample)
      samples.include?(audio)
    elsif audio.is_a?(Beat)
      beats.include?(audio)
    else
      false
    end
  end
end
