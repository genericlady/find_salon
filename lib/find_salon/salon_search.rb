class FindSalon::SalonSearch
  attr_reader :location

  def initialize(location)
    @location = location
    base_url = "https://maps.googleapis.com/maps/api/place/nearbysearch"
    query_params = "/json?location=#{location.latitude},#{location.longitude}&radius=500&rankby=prominence&type=beauty_salon&key=#{ENV['GOOGLE_PLACES_KEY']}"
    @full_url = base_url + query_params
  end

  def load_search_data
    uri = URI.parse(@full_url)
    response = Net::HTTP.get_response(uri)
    response.body
  end

  def data
    @data ||= load_search_data
  end

  def json
    @json ||= JSON.parse(data)
  end

  def results_data
    json["results"]
  end

  def resolve
    index = 0
    load_search_data
    results_data.each do |result_hash|
      FindSalon::Salon.new.tap do |r|
        r.id = index
        r.name = result_hash['name']
        r.vicinity = result_hash['vicinity']
        r.rating = result_hash['rating']
        r.google_place_id = result_hash['place_id']
        r.save
      end
      index += 1
    end
  end
end
