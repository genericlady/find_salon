require 'spec_helper'

describe FindSalon do
  it 'has a version number' do
    expect(FindSalon::VERSION).not_to be nil
  end

  describe 'FindSalon::CLI' do
    it 'is a constant within FindSalon' do
      expect(FindSalon::CLI).to be_a(Class)
    end
  end

  describe '#start' do
    it 'print a welcome message to the screen' do
      cli = FindSalon::CLI.new

      expect { cli.start }.to output("Welcome to FindSalon.\n").to_stdout
    end
  end

  describe '#list_salons' do
    it 'lists salons in numbered order.' do
      cli = FindSalon::CLI.new
      salon_info = <<-info.gsub /^\s*/,''
        1. Tease Hair Group - 4.6 - reviews: 10
        199 2nd Ave - (212) 725-7088
      info
      expect { cli.list_salons }.to output(salon_info).to_stdout
    end
  end
end
