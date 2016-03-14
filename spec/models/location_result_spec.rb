require 'spec_helper'

describe FindSalon::LocationResult, :vcr do
  let(:result) { FindSalon::LocationResult.new(
                              name: "Timothy John's Salon Inc",
                              vicinity: "313 West 53rd Street, New York",
                              rating: 4.3,
                              google_place_id: "ChIJ9woFm1dYwokRL4E4uGA663U"
                            ) }

  context 'properties' do
    it 'has attributes name, vicinity, rating and google_place_id' do
      expect(result).to have_attributes(
                          name: "Timothy John's Salon Inc",
                          vicinity: "313 West 53rd Street, New York",
                          rating: 4.3,
                          google_place_id: "ChIJ9woFm1dYwokRL4E4uGA663U"
                        )
    end
  end

  describe '#save' do
    it 'saves the result instance into all results' do
      result.save

      expect(FindSalon::LocationResult.all).to include(result)
    end
  end

  describe '.all' do
    it 'returns all my result instances' do
      result.save

      expect(FindSalon::LocationResult.all).to include(result)
    end
  end

  describe '.reset_all!' do
    it 'resets all results' do
      result.save

      FindSalon::LocationResult.reset_all!
      expect(FindSalon::LocationResult.all).to be_empty
    end
  end

  describe 'Enumerable#find' do
    it 'finds a salon by name from the search results' do
      result = FindSalon::LocationResult.new(

      )
    end
  end

  xdescribe '#load_details' do

  end

end
