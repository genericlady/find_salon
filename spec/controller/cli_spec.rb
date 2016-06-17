require 'spec_helper'

describe FindSalon::CLI, :vcr do
  let(:cli) { FindSalon::CLI.new('69.200.240.51') }

  it 'is a constant within FindSalon' do
    expect(FindSalon::CLI).to be_a(Class)
  end

  describe '#greet_user' do
    it 'print a welcome message to the screen' do
      expect(cli.greet_user).to include("Welcome to FindSalon.")
    end
  end

  describe '#user_location' do
    it 'returns the users city and state as a string' do
      expect(cli.user_location.city).to eq("Astoria")
      expect(cli.user_location.state).to eq("NY")
    end
  end

  describe '#is_location_correct?' do
    it 'asks the user if the location is correct?' do
      expect { cli.is_location_correct? }.to output("Is location correct? Y/n\n").to_stdout
    end
  end

  describe '#print_location' do
    it 'prints a users location' do
      expect { cli.print_location }.to output("You are in: Astoria, NY\n").to_stdout
    end
  end

  # describe '#menu' do
  #   menu = <<-details
  #     What would you like to do?
  #     Either type 'list' to list the results again or type an event number for more information.
  #   details
  #   it 'Asks what you want to do?' do
  #     expect{ cli.menu }.to output("What would you like to do?").to_stdout
  #   end
  # end
end
