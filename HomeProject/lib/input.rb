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
    return Integer(current)
    rescue ArgumentError => _exception 
        puts "Это не число или число не подходит в контексте программы, попробуйте еще раз"
  end
end


def self.need_parameter()
  loop do
    print 'why parameter for print tour(price/country/landmark)>'
    line=gets
    if line.nil? || line.strip.empty?
      puts "Вы ничего не ввели,введите требуемое значение"
      next
    end
    line=line.chomp
    if(line=='price' || line == 'country' || line == 'landmark')
      return line
    else 
      puts "Invalid parameter"
    end
  end
end


def self.need_type_transport(str)
  loop do
    print str
    line=gets
    if line.nil? || line.strip.empty?
      puts "Вы ничего не ввели,введите требуемое значение"
      next
    end
    line=line.chomp
    if(line=='bus' || line == 'train' || line == 'plane' || line == 'motorship')
      return line
    else 
      puts "Invalid type"
    end
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
      landmarks = tour['Landmark']
      duration = tour['Duration']
      info=Info.new(tour['Country']    ,tour['Type'])
      unless (tour['Type']=='bus' || tour['Type'] == 'train' || tour['Type'] == 'plane' || tour['Type'] == 'motorship')
        puts "Invalide type transport in file(tour.yaml)"    
        exit
      end
      price = tour['Price']
      num = tour['Num']
      new_tour = Tour.new(info,duration,price,num,landmarks)
      tdb.push(new_tour)
    end
    return tdb
end




def self.read_filetourists
    tdb=TouristDB.new
    all_info = Psych.load_file('../data/tourist.yaml')
    all_info.each do |tourist|
      landmark = tourist['Landmark']
      info=Info.new(tourist['Country']    ,tourist['Type'])
      unless (tourist['Type']=='bus' || tourist['Type'] == 'train' || tourist['Type'] == 'plane' || tourist['Type'] == 'motorship')
        puts "Invalide type transport in file(tourist.yaml)"    
        exit
      end
      person=Person.new(tourist['Name'],tourist['Surname'],tourist['Patronymic'])
      pricemin = tourist['Pricemin']
      pricemax = tourist['Pricemax']
      new_tourist = Tourist.new(info,person,landmark,pricemin,pricemax)
      tdb.push(new_tourist)
    end
    return tdb
end



end

