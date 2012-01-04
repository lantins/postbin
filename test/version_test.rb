require 'test_helper'

class TestVersion < MiniTest::Unit::TestCase
  def test_should_have_a_version
    assert PostBin::Version, 'unable to access the version number'
  end
end
