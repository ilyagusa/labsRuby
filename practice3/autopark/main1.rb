require_relative  "auto"
require_relative  "fleet"
n1_auto=Auto.new("audi","a4",2018,11)
n2_auto=Auto.new("opel","astra",2013,9)
n3_auto=Auto.new("zhigul","6",1997,9)
n4_auto=Auto.new("honda","cr-v",2003,11)
n5_auto=Auto.new("nissan","x-trail",2014,13)
n6_auto=Auto.new("audi","q5",2010,8)
n7_auto=Auto.new("bmw","x5",2011,14)
puts n1_auto
puts n2_auto
puts n3_auto
puts n4_auto
puts n5_auto
puts n6_auto
puts n7_auto

autopark=Fleet.new
autopark.add(n1_auto)
autopark.add(n2_auto)
autopark.add(n3_auto)
autopark.add(n4_auto)
autopark.add(n5_auto)
autopark.add(n6_auto)
autopark.add(n7_auto)
puts "AVGEXPENSE=#{autopark.avgexpense}"
puts "countbrand=#{autopark.count_brand("audi")}"

puts "countmodel=#{autopark.count_model("a4")}"
puts "AvgExpForBrand=#{autopark.avgexpense_for_brand("audi")}"