class FindSalon::CLI
  def start
    puts "Welcome to FindSalon."
  end

  def list_salons
    salon_info = <<-info.gsub(/^\s*/,'')
      1. Tease Hair Group - 4.6 - reviews: 10
      199 2nd Ave - (212) 725-7088
    info
    puts salon_info
  end
end
