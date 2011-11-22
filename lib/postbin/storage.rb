module PostBin

  # Storage backend for PostBin, uses PStore under the hood.
  class Storage

    def initialize(pstore_file)
      # setup file database for storage.
      @db = PStore.new(pstore_file)
    end

    # Store a post in the database.
    def store(url, post)
      @db.transaction do
        # init if no data exists.
        @db['urls'] ||= {}
        @db['urls'][url] ||= 0
        @db[url] ||= []
        # incr hit count.
        @db['urls'][url] += 1
        # store post.
        @db[url] << post
      end
    end

    # Returns hash, key being url and value being number of posts received.
    def hits
      @db.transaction(true) do
        @db['urls'] || {}
      end
    end

    # Returns array of urls that have been posted to.
    def urls
      @db.transaction(true) do
        (@db['urls'] || {}).keys
      end
    end

    # Returns array of posts for the given url.
    def posts(url)
      @db.transaction(true) do
        @db[url] || []
      end
    end

  end
end
