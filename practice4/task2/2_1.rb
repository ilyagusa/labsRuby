require_relative '../../input'
array=Array.new
puts "Введите массив в котором выведутся значения индекс которых степень двойки"
loop do
    current=input_number
    break  if current.nil?
    array<<Integer(current)
end

pow_two=1
array.each_with_index do |value, index|
    if index==pow_two
        print "array[#{index}=#{value}]"
        pow_two*=2
    end
end