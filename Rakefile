$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "zipmark/version"

require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb" # don't need this, it's default.
  # Put spec opts in a file named .rspec in root
end

desc "Build the Zipmark Gem"
task :build do
  system "gem build zipmark.gemspec"
end

desc "Build and Release the Zipmark Gem"
task :release => :build do
  system "gem push zipmark-#{Zipmark::VERSION}"
end
