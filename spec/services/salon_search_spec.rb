require 'spec_helper'

describe 'FindSalon::SalonSearch' do

  # vcr may need a specific cassette
  # describe '#resolve', :vcr do
  #   it 'resolves the Salon Search by creating and saving new salons' do
  #     expect(FindSalon::Salon.all.count).to eq(0)
  #     location = FindSalon::UserLocation.new_for_ip('167.187.200.23')
  #     FindSalon::SalonSearch.new(location).resolve
  #     expect(FindSalon::Salon.all.count).to eq(100)
  #
  #   end
  # end

  # describe '#location_details' do
  #   it 'retreives details of a location result using a google place id' do
  #     FindSalon::Salon.reset_all!
  #
  #     west_village_ny_location = FindSalon::UserLocation.new_for_ip('72.229.28.185')
  #     west_village_ny_location.load_results
  #     salon = FindSalon::Salon.find { |r| r.name == "Guy Thomas Hair Salon"}
  #     details = FindSalon::UserLocation.get_location_details(salon.google_place_id)
  #   end
  # end

end
