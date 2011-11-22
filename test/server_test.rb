require_relative 'test_helper'

class TestServer < MiniTest::Unit::TestCase
  def app
    PostBin::Server.new
    # use a new pstore file for each request.
    PostBin::Server.set :pstore_file, Tempfile.new(['postbin', 'pstore'])
  end

  def test_roots_should_redirect_to_overview
    get '/'
    follow_redirect!
    assert_equal '/postbin/overview', last_request.path
    assert last_response.ok?

    get '/postbin'
    follow_redirect!
    assert_equal '/postbin/overview', last_request.path
    assert last_response.ok?
  end

  def test_overview_returns_200
    get '/postbin/overview'
    assert_equal 200, last_response.status, 'status code should be 200 OK'
  end

  def test_accepts_post_requests
    post '/hello', 'foobar'
    assert_equal 201, last_response.status, 'status code should be 201 Created'
  end

  def test_accepts_posts_to_long_urls
    post '/foo/bar/is/very/long.php', 'hello world'
    assert_equal 201, last_response.status, 'status code should be 201 Created'
  end

  def test_json_url_hits
    get '/postbin/hits'
    assert_equal 200, last_response.status, 'status code should be 200 OK'
    assert_includes last_response.headers['Content-Type'], 'application/json', 'Content-Type header should be json'
  end

  def test_json_url_posts
    get '/postbin/posts'
    assert_equal 200, last_response.status, 'status code should be 200 OK'
    assert_includes last_response.headers['Content-Type'], 'application/json', 'Content-Type header should be json'
  end

  def test_post_and_read_back
    # post some data.
    post '/cats', 'they miaow'
    get '/postbin/hits'
    assert_equal '{"/cats":1}', last_response.body

    # read it back.
    get '/postbin/posts/cats'
    post = JSON.parse(last_response.body)[0]
    assert_equal 'they miaow', post['body']
  end


end
