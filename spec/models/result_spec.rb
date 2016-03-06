require 'spec_helper'

describe FindSalon::Result, :vcr do
  let(:result) { FindSalon::Result.new }

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

      expect(FindSalon::Result.all).to include(result)
    end
  end

  describe '.all' do
    it 'returns all my result instances' do
      result.save

      expect(FindSalon::Result.all).to include(result)
    end
  end

  describe '.reset_all!' do
    it 'resets all results' do
      result.save

      FindSalon::Result.reset_all!
      expect(FindSalon::Result.all).to be_empty
    end
  end

  xdescribe '.load from FindSalon' do
    it 'loads results from FindSalon' do
      FindSalon::Result.reset_all!
      FindSalon::Result.load_from_findsalon
      expect(FindSalon::Result.all).to_not be_empty

    end
  end
end
