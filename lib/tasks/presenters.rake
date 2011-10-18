require 'rspec/core'
require 'rspec/core/rake_task'

namespace :spec do
  desc "Run the code examples in spec/presenters"
  RSpec::Core::RakeTask.new(:presenters => 'db:test:prepare') do |t|
    t.pattern = "./spec/presenters/**/*_spec.rb"
  end
end
