begin
  require 'em-http'
  require 'em-synchrony'
  require 'em-synchrony/em-http'
rescue LoadError => ex
  puts "Could not load all libraries.\n
        :em_http adapter is not available."
end

module CouchDB::Proxy::Adapters

  # em-synchrony/em-http adapter
  #
  def perform_request_via_em_http(type, uri, options)
    options = options.merge(:head => {"content-type" => "application/json"})
    conn = EventMachine::HttpRequest.new(uri).send(type, options)
    { :status => conn.reponse_header.status, :body => conn.response }
  end

end
