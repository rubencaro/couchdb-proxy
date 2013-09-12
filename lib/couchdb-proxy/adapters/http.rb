begin
  require 'http'
rescue LoadError => ex
  puts "Could not load needed libraries. ':http' adapter is not available.",
      ex.to_s
end

module CouchDB
  class Proxy
    module Adapters

      # default adapter: http
      #
      def perform_request_via_http(type, uri, options)
        response = HTTP.with_response(:object).send(type, uri.to_s, options)
        { :status => response.status, :body => response.body }
      end

    end
  end
end
