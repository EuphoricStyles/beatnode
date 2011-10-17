require 'machinist/active_record'

User.blueprint do
  username { "testuser-#{sn}" }
  email { "test_email#{sn}@gmail.com" }
  bio { <<-EOB
  one time i made a beat and from then on i made beats.
  Once i made a beat about making beats!
  EOB
  }
  password { "password" }
  password_confirmation { "password" }
end

Beat.blueprint do
  name { "some beat-#{sn}" }
  description { "beat beat beat #{sn}." }
  audio { open("#{Rails.root}/data/audio/rickyrice.mp3") }
end

Sample.blueprint do
  description { "sample sample sample #{sn}." }
  audio { open("#{Rails.root}/data/audio/rickyrice.mp3") }
end

SampleUse.blueprint do
  # Attributes here
end

SampleBorrow.blueprint do
  # Attributes here
end

Comment.blueprint do
  b = <<-EOB
This is a multiline comment.

  It has some weird whitespace and stuff.
  EOB

  body { b }
end
