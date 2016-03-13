require 'spec_helper'

describe FindSalon::LocationResult, :vcr do
  let(:result) { FindSalon::LocationResult.new }

  context 'properties' do
    it 'has many attributes' do
      result.name = "Thai New York Spa & Salon"
      result.vicinity = "23-92 21st Street, Astoria"
      result.rating = 4.6
      result.place_id = "ChIJHck_2VpfwokRoXdg8srpPsQ"
      expect(result).to have_attributes(name: "Thai New York Spa & Salon",
                                        vicinity: "23-92 21st Street, Astoria",
                                        rating: 4.6,
                                        place_id: "ChIJHck_2VpfwokRoXdg8srpPsQ")
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

end
