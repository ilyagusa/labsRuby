def input_number
loop do
    current=gets
    if current=="\n"
        return nil
        break
    end
    current=Float(current)
    return current
rescue ArgumentError => _exception 
    puts "Это не число, попробуйте еще раз"
end
end
