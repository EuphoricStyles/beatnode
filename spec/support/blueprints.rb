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
  email { "test_email.#{sn}@gmail.com" }
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
