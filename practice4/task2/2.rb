require_relative '../../input'
array=Array.new
puts "Введите массив в котором выведутся значения индекс которых степень двойки"
loop do
    current=input_number
    break  if current.nil?
    array<<Integer(current)
end

pow_two=1
index=0
while(index < array.size)
    if index==pow_two
        print "array[#{index}=#{array[index]}]"
        pow_two*=2
    end
    index+=1
end