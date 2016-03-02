require 'pry'

class FindSalon::CLI
  attr_reader :external_ip

  def initialize(external_ip = nil)
    @external_ip = external_ip || self.class.get_external_ip
  end

  def start
    puts "Welcome to FindSalon."
    puts "You are in: " + user_location
  end

  def list_results
    salon_info = <<-info.gsub(/^\s*/,'')
      1. Tease Hair Group - 4.6 - reviews: 10
      199 2nd Ave - (212) 725-7088
    info
    puts salon_info
  end

  def self.get_external_ip
    `curl https://api.ipify.org --silent`
  end

  def user_location
    # geoip_city_data = {"city"=>{"names"=>{"en"=>"Astoria"}},
    #                      "subdivisions"=>
    #                       [{"names"=>
    #                          {"en"=>"New York",
    #                         "geoname_id"=>5128638}],
    #                      "location"=>
    #                       {"latitude"=>40.7732,
    #                        "longitude"=>-73.926}}}
    # json["latitude"] json["longitude"]
    geoip_city_data = Geoip2.client.city(external_ip)
    geoip_state_data = geoip_city_data["subdivisions"][0]
    @location_name = geoip_city_data["city"]["names"]["en"]+", "+geoip_state_data["names"]["en"]
  end

end
