require_relative '../../input'
array=Array.new
index_swap=Array.new
puts "Введите массив в котором будет подсчитано сколько раз сменился знак"
loop do
    current=input_number
    break  if current.nil?
    array<<Integer(current)
end
valueswap=0
chek=array[0]
array.each_with_index do |value, index|
        if  ((value<0 && chek>0) || (value>0 && chek<0))
        valueswap+=1
        index_swap<<index
        end
    chek=value
end

puts "Количество смен знак=#{valueswap}"
print "Индексы на которых сменялись знаки#{index_swap}"