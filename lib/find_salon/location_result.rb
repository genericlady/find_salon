require 'pry'

class FindSalon::LocationResult
  attr_accessor :name, :vicinity, :rating, :place_id

  @@all = Array.new
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
