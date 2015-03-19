f = File.new("./chicago data.csv", "r")
data_string = f.read
f.close

data_array = data_string.split("\n")
firstrow = data_array.shift

r = 0
data_array.each do |x|
  data_point = x.split(',')
  data_value = data_point[1].to_f
  r = r + data_value
end

mean = r/4295
puts "Mean ACT score:"
puts mean

n = 0
u = mean
data_array.each do |x|
  data_point = x.split(',')
  data_value = data_point[1].to_f
  num = (data_value-u)**2
  n = n + num
end

stddev = (n/4295)**0.5.to_f
puts "Standard Deviation:"
puts stddev

new_array = []
u = mean
data_array.each do |x|
  data_point = x.split(',')
  data_value = data_point[1].to_f
  zscores = (data_value-u)/stddev
  new_array.push(zscores)
end

final_array = []
4295.times do |i|
  final_array.push(data_array[i].to_s + "," + new_array[i].to_s)
end

final_array.unshift(firstrow)

f = File.new("./zscorefile.csv", "w")
f.write(final_array.join("\n"))
f.close