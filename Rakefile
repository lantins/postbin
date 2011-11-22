require 'rubygems' unless defined?(Gem)
require 'rake/testtask'

# by default run unit tests.
task :default => 'test:unit'

namespace :test do
  # unit tests.
  Rake::TestTask.new(:unit) do |task|
    task.test_files = FileList['test/**/*_test.rb']
    task.verbose = true
  end
end
