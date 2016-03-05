require 'spec_helper'

describe FindSalon::CLI, :vcr do
  let(:cli) { FindSalon::CLI.new('69.200.240.51') }

  describe '#initialize' do
    it 'accepts an initialize for the user' do
      expect(cli.external_ip).to eq('69.200.240.51')
    end

    it 'finds the external ip address of the user' do
      expect(FindSalon::CLI).to receive(:get_external_ip).and_return('69.200.240.81').at_least(:once)

      cli = FindSalon::CLI.new
      expect(cli.external_ip).to eq('69.200.240.81')
    end
  end

  it 'is a constant within FindSalon' do
    expect(FindSalon::CLI).to be_a(Class)
  end

  describe '#start' do
    it 'print a welcome message to the screen' do
      expect { cli.start }.to output("Welcome to FindSalon.\nYou are in: Astoria, New York\n").to_stdout
    end
  end

  describe '#user_location' do
    it "returns the user's City and State based off of FindSalon's geolocation." do
      expect(cli.user_location).to eq('Astoria, New York')
    end

    it 'sets a users latitude\longitude' do
      cli.user_location
      expect(cli.latitude).to eq(40.7611)
      expect(cli.longitude).to eq(-73.9319)
    end
  end

  describe '#list_results' do
    it 'lists results in numbered order.' do
      FindSalon::Result.reset_all!

      result_1 = FindSalon::Result.new
      result_1.name = "Result 1"
      result_1.save

      result_2 = FindSalon::Result.new
      result_2.name = "Result 2"
      result_2.save

      cli.list_results
      expect { cli.list_results }.to output("Salons near you:\n1. Result 1\n2. Result 2\n").to_stdout
    end
  end
end
