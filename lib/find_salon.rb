require "net/http"
require "uri"
require "json"
require 'pry'
require 'geoip2'

require "find_salon/version"
require "find_salon/cli"

module FindSalon
  # Your code goes here...
end

Geoip2.configure do |conf|
    # Mandatory
    conf.license_key = '109838'
    conf.user_id = '14Rm2Oy3WkxC'

    # Optional
    conf.host = 'geoip.maxmind.com' # Or any host that you would like to work with
    conf.base_path = '/geoip/v2.0' # Or any other version of this API
    conf.parallel_requests = 5 # Or any other amount of parallel requests that you would like to use
end
