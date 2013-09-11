require 'json'
require_relative 'couchdb-proxy/adapters'

class CouchDB::Proxy
  VERSION = '0.1.0'

  def self.connect(opts={})
    self.new(opts)
  end

  def initialize(opts={})
    @host = opts[:host] || '127.0.0.1'
    @port = opts[:port] || 5984
    @timeout = opts[:timeout] || 10
    @adapter = opts[:adapter] || CouchDB::Proxy::NetHttpAdapter.new
  end

  def json_request(type, path, opts)
    JSON.load @adapter.request(type, path, opts)
  end

end
