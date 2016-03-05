require 'spec_helper'
require 'pry'

describe FindSalon, :vcr do
  it 'has a version number' do
    expect(FindSalon::VERSION).not_to be nil
  end
end
