require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"
require "yard"

RuboCop::RakeTask.new
RSpec::Core::RakeTask.new
YARD::Rake::YardocTask.new

task default: [:rubocop, :spec]
