require_relative  "my_complex"
n1_complex=MyComplex.new(-2,3)
n2_complex=MyComplex.new(3,4)
p n1_complex
pp n2_complex
puts n1_complex
puts n2_complex
puts n1_complex.real
puts "N3=#{n1_complex.add(n2_complex)}"
puts "WORK"
