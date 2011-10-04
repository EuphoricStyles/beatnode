class User < ActiveRecord::Base
  has_many :beats, :dependent => :destroy
  has_many :owned_samples, :class_name => "Sample", :foreign_key => "owner_id"
  has_many :borrowed_samples, :class_name => "Sample"

  # call this from the sessions controller
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['omniauth.auth']
      user.uid = auth['uid']
      user.name = auth['user_info']['name']
    end
  end
end
