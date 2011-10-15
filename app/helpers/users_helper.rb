module UsersHelper
  def bio_for(user)
    user.bio.blank? ? "No bio." : user.bio
  end
end
