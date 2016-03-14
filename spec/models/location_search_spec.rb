require 'spec_helper'

context FindSalon::LocationSearch, :vcr do
  let(:location) { FindSalon::LocationSearch.new }

  describe '.new_for_ip' do
    it 'creates a new instance of a LocationSearch by ip' do
      beverly_hills_location = FindSalon::LocationSearch.new_for_ip('167.187.200.23')
      expect(beverly_hills_location).to have_attributes(
                                          city: "Beverly Hills",
                                          latitude: 34.0995,
                                          longitude: -118.4143,
                                          state: "CA"
                                        )
    end
  end

  describe 'initialize' do
    it "doesn't require arguments upon initialize" do
      expect(FindSalon::LocationSearch.new).to have_attributes(
                                                 city: nil,
                                                 latitude: nil,
                                                 longitude: nil,
                                                 state: nil
                                               )
    end

  end

  describe '#search_url' do
    it ""
  end

  xdescribe '#search_data' do

  end

  xdescribe '#json' do

  end

  xdescribe '#load_data' do

  end

  xdescribe '#json' do

  end

  describe '#user_location' do
    it "returns the user's City and State based off of FindSalon's geolocation." do
      location.city = 'Beverly Hills'
      location.state = 'CA'
      location.latitude = 34.0995
      location.longitude = -118.4143
      expect(location.user_location).to eq('Beverly Hills, CA')
    end
  end

  describe '#load_results' do
    it 'loads results from google places for FindSalon' do
      FindSalon::LocationResult.reset_all!
      beverly_hills_location = FindSalon::LocationSearch.new_for_ip('167.187.200.23')
      beverly_hills_location.load_results
      binding.pry

      expect(FindSalon::LocationResult.all).to_not be_empty
    end
  end

  describe '#location_details' do
    it 'retreives details of a location result using a google place id' do
      FindSalon::LocationResult.reset_all!

      west_village_ny_location = FindSalon::LocationSearch.new_for_ip('72.229.28.185')
      west_village_ny_location.load_results
      salon = FindSalon::LocationResult.find { |r| r.name == "Guy Thomas Hair Salon"}
      details = FindSalon::LocationSearch.get_location_details(salon.google_place_id)
    end
  end
end
