require 'spec_helper'

context FindSalon::UserLocation, :vcr do
  let(:location) { FindSalon::UserLocation.new }

  describe '.new_for_ip' do
    it 'creates a new instance of a UserLocation by ip' do
      beverly_hills_location = FindSalon::UserLocation.new_for_ip('167.187.200.23')
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
      expect(FindSalon::UserLocation.new).to have_attributes(
                                                 city: nil,
                                                 latitude: nil,
                                                 longitude: nil,
                                                 state: nil
                                               )
    end
  end

  describe '#user_location' do
    it "returns the user's City and State based off of FindSalon's geolocation." do
      location.city = 'Beverly Hills'
      location.state = 'CA'
      location.latitude = 34.0995
      location.longitude = -118.4143
      expect(location.city_and_state).to eq('Beverly Hills, CA')
    end
  end

end
