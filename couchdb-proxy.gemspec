# -*- encoding: utf-8 -*-
require "./lib/couchdb-proxy"

Gem::Specification.new do |s|
  s.name        = "couchdb-proxy"
  s.version     = CouchDB::Proxy::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ruben Caro"]
  s.email       = ["ruben.caro@lanuez.org"]
  s.homepage    = "https://github.com/rubencaro/couchdb-proxy"
  s.summary = "Proxy layer between couchdb HTTP API and your code"
  s.description = "Proxy layer between couchdb HTTP API and your code."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.require_paths = ["lib"]
  s.license = "GPLv3"

  s.required_ruby_version     = '>= 1.9.3'

  s.add_development_dependency 'minitest'
  s.add_development_dependency 'rake'
  s.add_runtime_dependency 'http'
end
