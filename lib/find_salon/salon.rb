class FindSalon::Salon
  attr_accessor :id, :name, :vicinity, :rating, :google_place_id
  @@all = Array.new

  def initialize(id: nil, name: nil, vicinity: nil, rating: nil, google_place_id: nil)
    @id = id
    @name = name
    @vicinity = vicinity
    @rating = rating
    @google_place_id = google_place_id
  end

  def save
    @@all << self
  end

  def self.find(id)
    salon = (@@all.select { |salon| salon.id.to_i == id })[0]
    [ 'name: ' + salon.name, 'rating: ' + salon_rating(salon), 'vicinity: ' + salon.vicinity ]
  end

  def self.all
    @@all
  end

  def self.salon_rating(place)
    if place.rating.nil?
      'not available'
    else
      place.rating.to_s
    end
  end

  def self.reset_all!
    @@all.clear
  end

end
