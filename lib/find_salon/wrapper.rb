require 'pry'
class FindSalon::Wrapper

  def initialize(latitude, longitude, city, state)
    @longitude = longitude
    @latitude = latitude
    @city = city
    @state = state
  end

  def data
    @data ||= load_data
  end

  def load_data
    url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{@latitude},#{@longitude}&radius=500&rankby=prominence&type=beauty_salon&key=#{ENV['GOOGLE_PLACES_KEY']}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    response.body
  end

  def user_location
    @city + ", " + @state
  end

  def json
    @json ||= JSON.parse(data)
  end

  def results_data
    json["results"]
  end

  def load_results
    results_data.each do |result_hash|
      r = FindSalon::Result.new
      r.name = result_hash['name']
      r.vicinity = result_hash['vicinity']
      r.rating = result_hash['rating']
      r.place_id = result_hash['place_id']
      r.save
    end
  end

end
