require 'spec_helper'

describe FindSalon::Place, :vcr do
  let(:place) { FindSalon::Place.new }

  it 'has many attributes' do
    place.name = "Thai New York Spa & Salon"
    place.place_id = "ChIJHck_2VpfwokRoXdg8srpPsQ"

    expect(place).to have_attributes(name: "Thai New York Spa & Salon",
                                      place_id: "ChIJHck_2VpfwokRoXdg8srpPsQ")
  end

end
