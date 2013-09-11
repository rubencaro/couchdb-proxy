require 'net/http'

# Simple adapter for regular Net::HTTP
#
class CouchDB::Proxy::NetHttpAdapter

  def request(type, path, options)
    uri = URI.parse("http://#{@host}:#{@port}#{path}")
    options = options.merge(:head => {"content-type" => "application/json"})
    conn = EventMachine::HttpRequest.new(uri).send type, options
  end

end
