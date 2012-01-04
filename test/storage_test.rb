require 'test_helper'

class TestStorage < MiniTest::Unit::TestCase

  def setup
    test_storage_tempfile = Tempfile.new(['postbin', 'pstore'])
    @storage_path = test_storage_tempfile.path
  end

  def test_new_instance
    assert PostBin::Storage.new(@storage_path)
  end

  def test_all_urls_returns_empty_hash_by_default
    storage = PostBin::Storage.new(@storage_path)
    assert_empty storage.urls, 'should return empty array by default'
  end

  def test_can_store_post
    storage = PostBin::Storage.new(@storage_path)
    post = PostBin::Post.new('1', '2')
    assert storage.store('/test/url', post)
  end

  def test_can_get_all_urls
    storage = PostBin::Storage.new(@storage_path)
    post = PostBin::Post.new('1', '2')
    storage.store('/foobar', post)

    expected = ['/foobar']
    assert_equal expected, storage.urls, 'all urls should be a populated array'
  end

  def test_keeps_count_of_posts_to_same_url
    storage = PostBin::Storage.new(@storage_path)
    post = PostBin::Post.new('1', '2')
    storage.store('/foobar', post)
    storage.store('/foobar', post)
    storage.store('/hello', post)

    hits = storage.hits
    assert_equal 2, hits['/foobar'], 'count should be 2'
    assert_equal 1, hits['/hello'], 'count should be 1'
  end

  def test_can_retrieve_saved_post_data
    storage = PostBin::Storage.new(@storage_path)
    post = PostBin::Post.new('4', '2')
    storage.store('/retrieve', post)

    posts = storage.posts('/retrieve')
    assert_equal post, posts[0], 'should match the post we stored'
  end

end
