class FindSalon::CLI
  attr_reader :user_location

  def initialize(external_ip = nil)
    @external_ip ||= self.class.get_external_ip
    @user_location ||= self.class.location_search_ip(@external_ip)
  end

  def start
    load_results
    puts greet_user
    print_location
    menu
  end

  # Conduct a search based off of user location and create new salons
  # Every subsequent call will erase the previous search and create a new one
  def load_results
    FindSalon::SalonSearch.new(user_location).resolve
  end

  # Results are cached in Salon.all
  def salons
    FindSalon::Salon.all.map do |salon|
      salon.id.to_s + ' ' + salon.name + ' | ' + 'Rating: ' + salon.rating.to_s + ' | ' + 'Address: ' + salon.vicinity
    end
  end

  def help
    puts [
          "\nType a command and hit enter",
          "q=quit, l=list_salons, c=change_location, f=find"
         ]
  end

  def menu
    input = String.new
    while input != 'q'
      if input == 'l'
        puts salons
      elsif input == 'c'
        change_location
        puts user_location.city + ', ' + user_location.state
        FindSalon::Salon.reset_all!
        load_results
        puts salons
      elsif input == 'f'
        puts ['Please enter the id number of salon:']
        puts find_salon_by_id
      end
      help
      input = gets.strip
    end
    puts 'Goodbye'
  end

  def find_salon_by_id
    id = gets.strip.to_i
    FindSalon::Salon.find(id)
  end

  def print_details(result)
    puts "Some details about the #{result.name}"
  end

  def greet_user
    "\nWelcome to FindSalon.\n\n"
  end

  def print_location
    puts "You are in: " + user_location.city + ', ' + user_location.state
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
