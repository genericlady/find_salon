require 'pry'

class FindSalon::LocationResult
  attr_accessor :name, :vicinity, :rating, :google_place_id

  @@all = Array.new

  def initialize(name: nil, vicinity: nil, rating: nil, google_place_id: nil)
    @name = name
    @vicinity = vicinity
    @rating = rating
    @google_place_id = google_place_id
  end

  def save
    @@all << self
  end

  def self.find(id)
    @@all[id.to_i-1]
  end

  def self.all
    @@all
  end

  def self.reset_all!
    @@all.clear
  end

end
