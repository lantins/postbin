require_relative 'test_helper'

class TestPost < MiniTest::Unit::TestCase

  def test_has_a_header_and_body
    post = PostBin::Post.new('header data', 'body data')
    assert_equal 'header data', post.headers, 'post headers not as we expect'
    assert_equal 'body data', post.body, 'post body not as we expect'
  end

  def test_has_received_at_timestamp
    post = PostBin::Post.new('headers', 'body')
    assert_kind_of Time, post.received_at
  end

  def test_we_can_set_received_at
    now = Time.now
    post = PostBin::Post.new('headers', 'body', now)
    assert_equal now, post.received_at
  end

  def test_double_equals_comparison_method
    now = Time.now
    post1 = PostBin::Post.new('headers', 'body', now)
    post2 = PostBin::Post.new('headers', 'body', now)
    assert_equal post1, post2, 'should be the same'
  end

end
