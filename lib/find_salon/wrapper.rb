require 'pry'
class FindSalon::Wrapper

  def initialize(latitude, longitude, city, state)
    @longitude = longitude
    @latitude = latitude
    @city = city
    @state = state
  end

  # data should be nearby_search_request
  def data
    unless @data
      url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{@latitude},#{@longitude}&radius=500&rankby=prominence&type=beauty_salon&key=#{ENV['GOOGLE_PLACES_KEY']}"
      uri = URI.parse(url)
      response = Net::HTTP.get_response(uri)
      @data = response.body
    else
      @data
    end
  end

  def text_search_request

  end

  def user_location
    @city + ", " + @state
  end

  # nearby_search_json
  def json
    @json ||= JSON.parse(data)
  end

  # text_search_json

  # nearby_search_results
  def results_data
    json["results"]
  end

  # text_search_results

  # load_nearby_search_results
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

  # load_text_search_results
end
