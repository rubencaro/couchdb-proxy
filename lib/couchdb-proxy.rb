require 'json'

# try loading available adapters
Dir[File.dirname(__FILE__) + '/couchdb-proxy/adapters/*.rb'].each do |file|
  begin
    require file
  rescue => ex
    puts ex.to_s
  end
end

module CouchDB
  class Proxy
    VERSION = '0.1.0'

    include CouchDB::Proxy::Adapters

    def self.connect(opts={})
      self.new(opts)
    end

    # options are:
    #   :host (default 127.0.0.1)
    #   :port (default 5984)
    #   :timeout (default 10)
    #   :adapter (default :http)
    #
    # 'adapter' can be any of the implemented 'perform_request_via_<adapter>' instance methods.
    # If yours is not implemented, you can add it anytime you want!
    # It will surely be no more than a couple of lines.
    # Just behave as the ones already implemented and everything will be ok.
    #
    def initialize(opts={})
      @adapter = opts[:adapter] || :http
      if not self.respond_to?("perform_request_via_#{@adapter}") then
        raise ArgumentError.new "Unknown adapter: '#{@adapter}'\nMaybe you should define 'perform_request_via_#{@adapter}'"
      end

      @host = opts[:host] || '127.0.0.1'
      @port = opts[:port] || 5984
      @timeout = opts[:timeout] || 10
    end

    # perform_request using the configured adapter
    #
    def request(type, path, opts)
      uri = URI.parse("http://#{@host}:#{@port}#{path}")
      response = self.send("perform_request_via_#{@adapter}",type,uri,options)
      JSON.load response
    end

  end
end
