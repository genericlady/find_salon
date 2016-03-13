require 'spec_helper'

describe FindSalon::LocationSearch, :vcr do
  let(:location_search) { FindSalon::LocationSearch.new(40.7611, -73.9319, 'Astoria', 'NY') }

  describe '#user_location' do
    it "returns the user's City and State based off of FindSalon's geolocation." do
      expect(location_search.user_location).to eq('Astoria, NY')
    end
  end

  describe '#load_results' do
    it 'loads results from google places for FindSalon' do
      FindSalon::LocationResult.reset_all!
      location_search.load_results
      expect(FindSalon::LocationResult.all).to_not be_empty
    end
  end
end
