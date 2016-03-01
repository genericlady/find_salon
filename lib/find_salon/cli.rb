class FindSalon::CLI
  attr_reader :external_ip

  def initialize(external_ip = nil)
    @external_ip = external_ip || self.class.get_external_ip
  end

  def start
    puts "Welcome to FindSalon."
  end

  def list_results
    salon_info = <<-info.gsub(/^\s*/,'')
      1. Tease Hair Group - 4.6 - reviews: 10
      199 2nd Ave - (212) 725-7088
    info
    puts salon_info
  end

  def self.get_external_ip
    `curl https://api.ipify.org`
  end

end
