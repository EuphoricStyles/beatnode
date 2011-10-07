require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end
#
User.blueprint do
  username { "testuser-#{sn}" }
  email { "test_email#{sn}@gmail.com" }
  password { "password" }
  password_confirmation { "password" }
end

Beat.blueprint do
  title { "some beat-#{sn}" }
  description { "beat beat beat #{sn}." }
  audio { open("#{Rails.root}/data/audio/rickyrice.mp3") }
end

Sample.blueprint do
  title { "some sample-#{sn}" }
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
