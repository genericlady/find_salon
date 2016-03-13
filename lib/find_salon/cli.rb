require 'pry'

class FindSalon::CLI
  attr_reader :external_ip, :user_location, :location_search

  def initialize(external_ip = nil)
    @external_ip = external_ip || self.class.get_external_ip
    @location_search = location_search || self.class.get_location_search(@external_ip)
  end

  def start
    greet_user
    print_location
    # while !is_location_correct?
    #    wrapper.location['Zip'] = get_zip_code
    #    wrapper.refresh_location
    # else
    #   list_results
    # end
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
        if result = FindSalon::LocationResult.find(input)
          print_details(result)
        else
          puts "Can't find a result, try number's between 1-#{FindSalon::LocationResult.all.size}"
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

  def is_location_correct?
    puts "Is location correct? Y/n"
  end

  def list_results
    puts "Salons near you:"
    FindSalon::LocationResult.all.each.with_index(1) do |result, i|
      puts "#{i}. #{result.name} - Rating: #{result.rating}"
      puts "#{result.vicinity}"
    end
  end

  def self.get_external_ip
    `curl https://api.ipify.org --silent`
  end

  def self.get_location_search(external_ip)
    @location_search = FindSalon::LocationSearch.new_for_ip(external_ip)
    @location_search.load_results
    @location_search
  end

  def user_location
    location_search.user_location
  end
end
