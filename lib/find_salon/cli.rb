require 'pry'

class FindSalon::CLI
  attr_reader :external_ip, :user_location

  def initialize(external_ip = nil)
    @external_ip = external_ip || self.class.get_external_ip
    geoip2_city_data = Geoip2.client.city(@external_ip)
    latitude = geoip2_city_data["location"]["latitude"]
    longitude = geoip2_city_data["location"]["longitude"]
    city = geoip2_city_data["subdivisions"][0]['names']['en']
    state = geoip2_city_data["city"]["names"]["en"]
    @wrapper = FindSalon::Wrapper.new(latitude, longitude, state, city)
    @wrapper.load_results
  end

  def start
    greet_user
    print_location
    is_location_correct?
    list_results
    menu
  end

  def help
    puts "What would you like to do?"
    # if there are more results to display
    # type 'next' for more results
    # if there are previous results to display
    # type 'previous' for previous results
    puts "Type 'next' for more results"
    puts "Choose a number for salon details or"
    puts "Type 'q' for quit"
  end

  def menu
    help
    input = gets.strip
    while input != 'exit'
      if input == 'list'
        list_results
      else
        if result = FindSalon::Result.all[input.to_i-1]
          print_details(result)
        else
          puts "Can't find a result, try number's between 1-#{FindSalon::Result.all.size}"
        end
      end
      help
      input = gets.strip
    end
    puts 'Goodbye'
  end

  def print_details(result)
    puts "Some details about the #{result.name}"
  end

  def greet_user
    puts "Welcome to FindSalon."
  end

  def print_location
    puts "You are in: " + user_location
  end

  def list_results
    puts "Salons near you:"
    FindSalon::Result.all.each.with_index(1) do |result, i|
      puts "#{i}. #{result.name} - Rating: #{result.rating}"
      puts "#{result.vicinity}"
    end
  end

  def self.get_external_ip
    `curl https://api.ipify.org --silent`
  end

  def user_location
    @wrapper.user_location
  end
end
