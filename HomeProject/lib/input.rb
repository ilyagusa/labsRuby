require 'yaml'
require_relative 'tour_data_base'
require_relative 'tour'
require_relative 'info'
require_relative 'tourist_data_base'
require_relative 'person'
#1
module Input 

def self.need_num(str)
  loop do
    print str
    current=gets
    if current.to_i<=0
        current="a";
    end
    if current=="\n"
        return nil
    end
    current=Float(current)
    return current
    rescue ArgumentError => _exception 
        puts "Это не число или данное отрицательное, попробуйте еще раз"
  end
end


def self.need_string(str)
  loop do
    print str
    line=gets
    if line.nil?
      puts "Вы ничего не ввели,введите требуемое значение"
      next
    end
    line=line.strip
    if line.empty?
      puts "Вы ничего не ввели, введите требуемое значение"
      next
    end
    return line.chomp
  end
end


def self.read_filetours
    tdb=TourDB.new
    all_info = Psych.load_file('../data/tours.yaml')
    all_info.each do |tour|
      landmarks=[]
      country = tour['Country']    
      landmarks = tour['Landmark']
      duration = tour['Duration']
      type = tour['Type']
      price = tour['Price']
      num = tour['Num']
      new_tour = Tour.new(Info.new(country,type),duration,price,num,landmarks)
      tdb.push(new_tour)
    end
    return tdb
end




def self.read_filetourists
    tdb=TouristDB.new
    all_info = Psych.load_file('../data/tourist.yaml')
    all_info.each do |tourist|
      country = tourist['Country']    
      type = tourist['Type']
      landmark = tourist['Landmark']
      name = tourist['Name']
      surname = tourist['Surname']
      patr = tourist['Patronymic']
      pricemin = tourist['Pricemin']
      pricemax = tourist['Pricemax']
      new_tourist = Tourist.new(Info.new(country,type),Person.new(name,surname,patr),landmark,pricemin,pricemax)
      tdb.push(new_tourist)
    end
    return tdb
end



end

