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
    use_samples
    borrow_samples
    make_user_relationships
  end
end

def make_users
  User.create! :username => 'alexgenco', :email => 'alexgenco@gmail.com', 
               :password => 'password', :password_confirmation => 'password'

  10.times do |n|
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
  User.all.each do |user|
    3.times do
      description = Faker::Lorem.sentence(5)
      user.samples.create!(:description => description, :audio => audio_file)
    end
  end
end

def make_beats
  User.all.each do |user|
    5.times do
      name = Faker::Name.name
      description = Faker::Lorem.sentence(5)
      user.beats.create!(:name => name, :description => description, :audio => audio_file)
    end
  end
end

def use_samples
  Beat.all.each do |beat|
    sample_id = rand(Sample.count)
    beat.sample_uses.create!(:sample_id => sample_id)
  end
end

def borrow_samples
  User.all.each do |user|
    5.times do |i|
      sample = Sample.all[i]
      user.borrow!(sample)
    end
  end
end

def make_user_relationships
  users = User.all
  user  = users.first
  watching = users[1..10]
  watchers = users[3..20]
  watching.each { |watched| user.watch!(watched) }
  watchers.each { |watcher| watcher.watch!(user) }
end
