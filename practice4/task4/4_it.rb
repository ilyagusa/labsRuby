require_relative '../input'
array=Array.new
puts "Введите массив где будут удалены нули и остальные элементы сдвинуца влева"
loop do
    current=input_number
    break  if current.nil?
    array<<Integer(current)
end
array.delete_if {|value| value==0}
print array

