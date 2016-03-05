require 'pry'

class FindSalon::Result
  attr_accessor :name, :vicinity, :rating, :place_id

  @@all = Array.new
  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.reset_all!
    @@all.clear
  end

  def self.load_from_findsalon
    uri = URI.parse("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=40.7732,-73.926&radius=500&type=beauty_salon&key=#{ENV['GOOGLE_PLACES_KEY']}")

    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body)
  end
end
