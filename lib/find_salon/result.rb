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

  end
end
