class User < ActiveRecord::Base
  has_many :beats

  # call this from the sessions controller
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['omniauth.auth']
      user.uid      = auth['uid']
      user.name     = auth['user_info']['name']
    end
  end
end
