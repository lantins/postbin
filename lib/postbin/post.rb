module PostBin

  # Represents header/body information of a HTTP POST request.
  class Post
    attr_reader :received_at, :headers, :body

    def initialize(headers, body, received_at = nil)
      @received_at = received_at || Time.now
      @headers = headers
      @body = body
    end

    # Returns true only if the two posts contain equal data.
    def ==(other)
      return false unless Post === other
      return false unless received_at == other.received_at
      return false unless headers == other.headers
      body == other.body
    end

    def to_json
      Yajl::Encoder.encode({ :received_at => received_at, :headers => headers, :body => body })
    end

  end
end
