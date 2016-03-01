require 'pry'

class FindSalon::CLI
  attr_reader :external_ip, :location_name

  def initialize(external_ip = nil)
    @external_ip = external_ip || self.class.get_external_ip
  end

  def start
    puts "Welcome to FindSalon."
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
    url = "http://freegeoip.net:80/json/#{external_ip}"
    # json = {
    #   ip: "69.200.240.81",
    #   country_code: "US",
    #   country_name: "United States",
    #   region_code: "NY",
    #   region_name: "New York",
    #   city: "Astoria",
    #   zip_code: "11102",
    #   time_zone: "America/New_York",
    #   latitude: 40.7732,
    #   longitude: -73.926,
    #   metro_code: 501
    # }

    # json["latitude"] json["longitude"]
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    data = response.body
    binding.pry
    json = JSON.parse(data)
    @location_name = json["city"]+", "+json["region_code"]
  end

end
