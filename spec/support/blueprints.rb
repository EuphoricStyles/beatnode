require 'machinist/active_record'

class String
  def size_to(range)
    self.length < range.min ? self + ('a'*(range.min - length)) : self[0..range.max-1]
  end
end

def valid_paragraph(range)
  Faker::Lorem.paragraph(rand(10)).size_to(range)
end

def valid_username(range)
  Faker::Internet.user_name.size_to(range) 
end

def valid_name(range)
  Faker::Name.name.size_to(range) 
end

def valid_email
  Faker::Internet.email
end

User.blueprint do
  username { valid_username(4..20) }
  email { valid_email }
  bio { valid_paragraph(0..600) }
  password { "password" }
  password_confirmation { "password" }
end

Beat.blueprint do
  name { valid_name(0..75) }
  description { valid_paragraph(0..200) }
  audio { open("#{Rails.root}/data/audio/rickyrice.mp3") }
end

Sample.blueprint do
  description { valid_paragraph(0..200) }
  audio { open("#{Rails.root}/data/audio/rickyrice.mp3") }
end

SampleUse.blueprint do
  beat { Beat.make! }
  sample { Sample.make! }
end

SampleBorrow.blueprint do
  # Attributes here
end

Comment.blueprint do
  body { valid_paragraph(0..200) }
end

UserRelationship.blueprint do
  # Attributes here
end
