require 'rubygems' unless defined?(Gem)
#
# Test helper init script.
#
require 'simplecov'

# code coverage groups.
SimpleCov.start do
  add_filter 'test/'
end

# load our dependencies using bundler.
require 'bundler/setup'
Bundler.setup
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'

# load postbin lib.
require 'postbin'

# extend main TestCase
class MiniTest::Unit::TestCase
  include Rack::Test::Methods
end
