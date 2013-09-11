require 'http'

module CouchDB::Proxy::Adapters

  # default adapter: http
  #
  def perform_request_via_http(type, uri, options)
    response = HTTP.with_response(:object).send(type, uri.to_s, options)
    { :status => response.status, :body => response.body }
  end

end
