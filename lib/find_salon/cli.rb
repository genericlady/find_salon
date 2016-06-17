class FindSalon::CLI
  attr_reader :user_location

  def initialize(external_ip = nil)
    @external_ip ||= self.class.get_external_ip
    @user_location ||= self.class.location_search_ip(@external_ip)
  end

  def start
    load_results
    greet_user
    print_location
    puts salons
    menu
  end

  # Conduct a search based off of user location and create new salons
  # Every subsequent call will erase the previous search and create a new one
  def load_results
    FindSalon::SalonSearch.new(user_location).create_salons
  end

  # Results are cached in Salon.all
  def salons
    FindSalon::Salon.all.map do |salon|
      salon.id.to_s + ' ' + salon.name + '-' + salon.rating.to_s + ' ' + salon.vicinity
    end
  end

  def help
    puts [
          "\nType a command and hit enter",
          "q=quit, l=list_salons, c=change_location \n\n",
         ]
  end

  def menu
    input = String.new
    while input != 'q'
      if input == 'l'
        puts salons
      elsif input == 'c'
        change_location
        load_results
        puts nearby_salons
      elsif (0..10).include?(input.to_i)
        puts FindSalon::Salon.find(input.to_i)
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
    puts "\nWelcome to FindSalon.\n\n"
  end

  def print_location
    puts ["You are in: " + user_location.city, '']
  end

  def is_location_correct?
    puts "Is location correct? Y/n"
  end

  def self.get_external_ip
    `curl https://api.ipify.org --silent`
  end

  def self.location_search_ip(external_ip)
    FindSalon::UserLocation.new_for_ip(external_ip)
  end

  def change_location
    puts ["Please enter address city and state, e.g.",
         '140 Market St, San Francisco, CA']

    address = gets.strip
    @user_location = FindSalon::UserLocation.new_for_address(address)
  end
end
