$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'find_salon'
require 'vcr'
require 'webmock/rspec'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
