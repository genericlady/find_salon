require 'pry'

class FindSalon::CLI
  attr_reader :external_ip, :user_location, :latitude, :longitude

  def initialize(external_ip = nil)
    @external_ip = external_ip || self.class.get_external_ip
  end

  def start
    puts "Welcome to FindSalon."
    puts "You are in: " + user_location
  end

  def list_results
    FindSalon::Result.all.each { |e|  }
    salon_info = <<-info.gsub(/^\s*/,'')
      1. Tease Hair Group - 4.6
      199 2nd Ave
    info
    puts salon_info
  end

  def self.get_external_ip
    `curl https://api.ipify.org --silent`
  end

  def user_location
    geoip2_city_data = Geoip2.client.city(external_ip)
    @latitude = geoip2_city_data["location"]["latitude"]
    @longitude = geoip2_city_data["location"]["longitude"]
    state = geoip2_city_data["subdivisions"][0]['names']['en']
    city = geoip2_city_data["city"]["names"]["en"]
    @user_location = city + ", " + state
  end

end
