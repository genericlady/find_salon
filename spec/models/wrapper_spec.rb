require 'spec_helper'

describe FindSalon::Wrapper, :vcr do
  let(:wrapper) { FindSalon::Wrapper.new(40.7611, -73.9319, 'Astoria', 'New York') }

  describe '#user_location' do
    it "returns the user's City and State based off of FindSalon's geolocation." do
      expect(wrapper.user_location).to eq('Astoria, New York')
    end
  end

  describe '#load_results' do
    it 'loads results from google places for FindSalon' do
      FindSalon::Result.reset_all!
      wrapper.load_results
      expect(FindSalon::Result.all).to_not be_empty
    end
  end
end
