require_relative '../../input'
array=Array.new
index_swap=Array.new
puts "Введите массив в котором будет подсчитано сколько раз сменился знак"
loop do
    current=input_number
    break  if current.nil?
    array<<Integer(current)
end
index=1
valueswap=0
while(index<array.size)
        if ((array[index-1]>0 && array[index]<0) || (array[index-1]<0 && array[index]>0))
        index_swap<<index
        valueswap+=1
        end
    index+=1
end
puts "Количество смен знак=#{valueswap}"
print "Индексы на которых сменялись знаки#{index_swap}"