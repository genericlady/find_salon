require 'spec_helper'

describe FindSalon, :vcr do
  it 'has a version number' do
    expect(FindSalon::VERSION).not_to be nil
  end

  describe 'FindSalon::CLI' do
    let(:cli) { FindSalon::CLI.new('69.200.240.51') }

    context '#initialize' do
      it 'accepts an initialize for the user' do
        expect(cli.external_ip).to eq('69.200.240.51')
      end

      it 'finds the external ip address of the user' do
        expect(FindSalon::CLI).to receive(:get_external_ip).and_return('69.200.240.81')

        cli = FindSalon::CLI.new
        expect(cli.external_ip).to eq('69.200.240.81')
      end
    end

    it 'is a constant within FindSalon' do
      expect(FindSalon::CLI).to be_a(Class)
    end

    context '#start' do
      it 'print a welcome message to the screen' do
        VCR.use_cassette('find-salon-user-location') do
          expect { cli.start }.to output("Welcome to FindSalon.\nYou are in: Astoria, New York\n").to_stdout
        end
      end
    end

    context '#user_location' do
      it "returns the user's City and State based off of FindSalon's geolocation." do
        VCR.use_cassette('find-salon-user-location') do
          expect(cli.user_location).to eq('Astoria, New York')
        end
      end
    end

    context '#list_results' do
      it 'lists results in numbered order.' do
        salon_info = <<-info.gsub /^\s*/,''
          1. Tease Hair Group - 4.6 - reviews: 10
          199 2nd Ave - (212) 725-7088
        info
        expect { cli.list_results }.to output(salon_info).to_stdout
      end
    end
  end
end
