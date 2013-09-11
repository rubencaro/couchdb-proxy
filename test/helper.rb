require 'minitest/pride'
require 'minitest/autorun'

require_relative '../lib/couchdb-proxy'


class FakeException < StandardError; end

def force_constant(klass, name, value)
  previous_value = klass.send(:remove_const, name)
  klass.const_set name.to_s, value
  previous_value
end
