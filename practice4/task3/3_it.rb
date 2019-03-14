require_relative '../input'
polinom=Array.new
puts "Введите коэффициенты полинома,где первое введенное число коэффициент при максимальной степени полинома"
loop do
    current=input_number
    break  if current.nil?
    polinom<<Integer(current)
end

def printed(polinom1)
    size=(polinom1.size-1)
    polinom1.each do |value|
        if (size>=1)
            print"#{value}*x^#{size}"
            print "+"
            size-=1
        else 
            print "#{value}"
        end
    end
end

def calculation(polinom1,tochka)
    size=polinom1.size
    sum=0
    polinom1.each do |value|
      temp=Integer(tochka**(size-1))
      sum+=temp*value
      size-=1
    end
    puts "ValuePolinom=#{sum}"
end


def derivative(polinom1, tochka)
    size=polinom1.size
    sum=0
    if tochka==0
      puts "sum=0"
      return
    end
    polinom1.each do |value|
        temp=Integer(tochka**(size-2))
        sum+=temp*value*(size-1)
        break if size==0
        size-=1
    end
    puts "derivative=#{sum}"
end

printed(polinom)
print"Введите точку в которой программа посчитает полином и его производную>"
a=input_number
calculation(polinom,a)
derivative(polinom,a)