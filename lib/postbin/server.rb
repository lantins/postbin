module PostBin
  class Server < Sinatra::Base

    dir = File.dirname(File.expand_path(__FILE__))

    set :views,  "#{dir}/server/views"
    set :public_folder, "#{dir}/server/public"
    set :static, true

    # by default we store in a temp file.
    set :pstore_file, Tempfile.new(['postbin', 'pstore']).path

    # Redirect lost users.
    get '/?' do;         redirect '/postbin/overview'; end
    get '/postbin/?' do; redirect '/postbin/overview'; end

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
      MultiJson.encode(storage.hits)
    end

    # Display posts for the given URL as JSON.
    get %r{/postbin/posts(.*)} do
      url = params[:captures].first
      storage = PostBin::Storage.new(settings.pstore_file)

      content_type :json
      MultiJson.encode(storage.posts(url))
    end

    # Catch all for post requests.
    post '*' do
      storage = PostBin::Storage.new(settings.pstore_file)
      post = PostBin::Post.new(client_request_headers, request.body.read)
      storage.store(request.path, post)
      status 201
    end

    # Runs a server on local machine, called by command line executable.
    def self.run_command_line!(argv)
      options = parse_args(argv)
      $stderr.puts "== Starting PostBin on http://#{options[:bind]}:#{options[:port]}"
      run!(options)
    end

    # Parse command line args.
    def self.parse_args(argv)
      # default options.
      options = { :bind => '127.0.0.1', :port => 6969, :server => 'thin', :enviroment => :production }

      # available options.
      opts = OptionParser.new('', 24, '  ') do |opts|
        opts.banner = 'Usage: postbin [options]'
        opts.separator ''
        opts.separator 'PostBin options:'
        opts.on('-v', '--version', 'show version number') { $stderr.puts 'PostBin ' + PostBin::Version; exit }
        opts.on('-h', '--help', 'show this message') { $stderr.puts opts; exit; }
        opts.separator ''
        opts.separator 'Rack options:'
        opts.on('-s', '--server SERVER', 'server (webrick, mongrel, thin, etc.)') { |s| options[:server] = s }
        opts.on('-a', '--address HOST', 'listen on HOST address (default: 127.0.0.1)') { |host| options[:bind] = host }
        opts.on('-p', '--port PORT', 'use PORT number (default: 6969)') { |port| options[:port] = port }
      end.parse!(argv)

      options
    end

    private
    # Returns an array of all client side HTTP request headers.
    def client_request_headers
      # POST /some/url HTTP/1.1
      # Accept: application/json
      # Content-Type: application/json
      headers = request.env.select { |k,v| k.start_with? 'HTTP_' } \
        .collect { |pair| [ pair[0].sub(/^HTTP_/, ''), pair[1] ] } \
        .collect { |pair| pair.join(': ') }

      headers
    end

  end
end
