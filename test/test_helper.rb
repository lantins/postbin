#
# Test helper init script.
#

# --- load rubygems if needed ------------------------------------------------
require 'rubygems' unless defined?(Gem)

# --- load simplecov if the gem is installed ---------------------------------
begin
  require 'simplecov'

  # code coverage groups.
  SimpleCov.start do
    add_filter 'test/'
  end
rescue LoadError
  # dont run code coverage if gem isn't installed.
end

# --- load our dependencies using bundler ------------------------------------
require 'bundler/setup'
Bundler.setup
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'

# --- load postbin lib -------------------------------------------------------
require 'postbin'

# --- extend main TestCase ---------------------------------------------------
class MiniTest::Unit::TestCase
  include Rack::Test::Methods
end
