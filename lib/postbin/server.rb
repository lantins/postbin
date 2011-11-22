module PostBin
  class Server < Sinatra::Base

    dir = File.dirname(File.expand_path(__FILE__))

    set :views,  "#{dir}/server/views"
    set :public_folder, "#{dir}/server/public"
    set :static, true

    # by default we store in a temp file.
    set :pstore_file, Tempfile.new(['postbin', 'pstore'])

    # Redirect lost users.
    get '/?' do;         redirect '/postbin/overview'; end
    get '/postbin/?' do;  redirect '/postbin/overview'; end

    # Display main overview.
    get '/postbin/overview' do
      storage = PostBin::Storage.new(settings.pstore_file)
      # pull out all urls and there posts.
      @url_hits = storage.hits

      @url_posts = @url_hits.inject({}) do |result, data|
        url, hits = *data
        result[url] = storage.posts(url)
        result
      end

      erb :overview
    end

    # Display urls and there hit count as JSON.
    get '/postbin/hits' do
      storage = PostBin::Storage.new(settings.pstore_file)

      content_type :json
      storage.hits.to_json
    end

    # Display posts for the given URL as JSON.
    get %r{/postbin/posts(.*)} do
      url = params[:captures].first
      storage = PostBin::Storage.new(settings.pstore_file)

      content_type :json
      storage.posts(url).to_json
    end

    # Catch all for post requests.
    post '*' do
      storage = PostBin::Storage.new(settings.pstore_file)
      post = PostBin::Post.new(client_request_headers, request.body.read)
      storage.store(request.path, post)
      status 201
    end

    private
    # Returns an array of all client side HTTP request headers.
    def client_request_headers
      # POST /some/url HTTP/1.1
      # Accept: application/json
      # Content-Type: application/json
      headers = request.env.select { |k,v| k.start_with? 'HTTP_' }
        .collect { |pair| [ pair[0].sub(/^HTTP_/, ''), pair[1] ] }
        .collect { |pair| pair.join(': ') }

      headers
    end

  end
end
