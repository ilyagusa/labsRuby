require_relative '../input'
array=Array.new
puts "Введите массив где будут удалены нули и остальные элементы сдвинуца влева"
loop do
    current=input_number
    break  if current.nil?
    array<<Integer(current)
end
i=0
while(i<array.size)
  if(array[i]==0)
    array.delete_at(i)
    i-=1
  end
  i+=1
end

print array

