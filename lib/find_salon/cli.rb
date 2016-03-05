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
    puts "Salons near you:"
    FindSalon::Result.all.each.with_index(1) do |result, i|
      puts "#{i}. #{result.name}"
    end
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
