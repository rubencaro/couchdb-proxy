begin
  require 'celluloid/io'
rescue LoadError => ex
  puts "Could not load 'celluloid/io'.\n
        :celluloid_http adapter is not available."
end

require 'http'

module CouchDB::Proxy::Adapters

  # celluloid-patched http
  #
  def perform_request_via_celluloid_http(type, uri, options)
    options.merge!(:socket_class => Celluloid::IO::TCPSocket, :ssl_socket_class => Celluloid::IO::SSLSocket)
    response = HTTP.with_response(:object).send(type, uri.to_s, options)
    { :status => response.status, :body => response.body }
  end

end
