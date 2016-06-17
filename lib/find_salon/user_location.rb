class FindSalon::UserLocation
  attr_accessor :latitude, :longitude, :city, :state

  def self.new_for_ip(ip)
    location = Geokit::Geocoders::MultiGeocoder.geocode(ip)
    self.new_user_location(location)
  end

  def self.new_for_address(address)
    location = Geokit::Geocoders::MultiGeocoder.geocode(address)
    self.new_user_location(location)
  end

  def self.new_user_location(location)
    FindSalon::UserLocation.new(location.lat, location.lng, location.city, location.state)
  end

  def initialize(latitude=nil, longitude=nil, city=nil, state=nil)
    @latitude = latitude
    @longitude = longitude
    @city = city
    @state = state
  end

  def city_and_state
    city + ', ' + state
  end
end
