def audio_file
  open "#{Rails.root}/data/audio/rickyrice.mp3"
end

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_samples
    make_beats
    borrow_samples
    make_user_relationships
  end
end

def make_users
  User.create! :username => 'alexgenco', :email => 'alexgenco@gmail.com', 
               :password => 'password', :password_confirmation => 'password'

  50.times do |n|
    username  = "username_#{n}"
    email = Faker::Internet.email
    password  = "password"
    User.create!(:username => username,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
  end
end

def make_samples
  User.all(:limit => 6).each do |user|
    10.times do
      description = Faker::Lorem.sentence(5)
      user.samples.create!(:description => description, :audio => audio_file)
    end
  end
end

def make_beats
  User.all(:limit => 6).each do |user|
    10.times do
      name = Faker::Name.name
      description = Faker::Lorem.sentence(5)
      user.beats.create!(:name => name, :description => description, :audio => audio_file)
    end
  end
end

def borrow_samples
  User.all(:limit => 6).each do |user|
    10.times do |i|
      sample = Sample.all[i]
      user.borrow!(sample)
    end
  end
end

def make_user_relationships
  users = User.all
  user  = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.watch!(followed) }
  followers.each { |follower| follower.watch!(user) }
end
