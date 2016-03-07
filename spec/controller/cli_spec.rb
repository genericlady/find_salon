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

  describe '#greet_user' do
    it 'print a welcome message to the screen' do
      expect { cli.greet_user }.to output("Welcome to FindSalon.\n").to_stdout
    end
  end

  describe '#user_location' do
    it 'returns the users city and state as a string' do
      expect(cli.user_location).to eq("Astoria, New York")
    end
  end

  describe '#print_location' do
    it 'prints a users location' do
      expect { cli.print_location }.to output("You are in: Astoria, New York\n").to_stdout
    end
  end

  describe '#list_results' do
    it 'lists results in numbered order.' do
      cli
      FindSalon::Result.reset_all!

      result_1 = FindSalon::Result.new
      result_1.name = "Result 1"
      result_1.rating = 4
      result_1.save

      result_2 = FindSalon::Result.new
      result_2.name = "Result 2"
      result_2.rating = 3
      result_2.save

      expect { cli.list_results }.to output("Salons near you:\n1. Result 1 - Rating: 4\n\n2. Result 2 - Rating: 3\n\n").to_stdout
    end
  end

  xdescribe '#menu' do
    menu = <<-details
      What would you like to do?
      Either type 'list' to list the results again or type an event number for more information.
    details
    it 'Asks what you want to do?' do
      expect{ cli.menu }.to output("What would you like to do?").to_stdout
    end
  end
end
