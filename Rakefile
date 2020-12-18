require 'rubygems' unless defined?(Gem)
require 'rake/testtask'
require 'rubygems/tasks'

# by default run unit tests.
task :default => 'test'

# unit tests.
Rake::TestTask.new(:test) do |task|
  task.libs << 'test'
  task.test_files = FileList['test/**/*_test.rb']
  task.verbose = true
end

# gem build/relase tasks
Gem::Tasks.new(
  build: {gem: true},
)
