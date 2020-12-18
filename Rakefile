require 'rubygems' unless defined?(Gem)
require 'rake/testtask'
require 'rubygems/tasks'
require './lib/postbin/version'

DOCKER_IMAGE_NAME   = "postbin"
BUILD_VERSION       = PostBin::Version
BUILD_ARTIFACT_REF  = "#{BUILD_VERSION}-" + %x(git rev-parse --short=8 HEAD).strip

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

# build local docker image
desc "Build local docker image"
task "docker-image" do |t, args|
  sh %Q(
    docker build \
      --tag "#{DOCKER_IMAGE_NAME}:latest" \
      --tag "#{DOCKER_IMAGE_NAME}:#{BUILD_ARTIFACT_REF}" \
      .
  )

end
