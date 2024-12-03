# Input

input = File.read("input.txt")
lines = input.split("\n")

# Part 1

nums = []

lines.each do |line|
  tens = line[line.index(/\d/)].to_i
  units = line[line.rindex(/\d/)].to_i
  nums << tens * 10 + units
end

p nums.sum

# Part 2

tens = []
units = []

lines.each do |line|
  line = line[line.index(/\d|one|two|three|four|five|six|seven|eight|nine/i)..]
  if line.start_with?(/\d/) then
    tens << line[0].to_i
  elsif line.start_with?('one') then
    tens << 1
  elsif line.start_with?('two') then
    tens << 2
  elsif line.start_with?('three') then
    tens << 3
  elsif line.start_with?('four') then
    tens << 4
  elsif line.start_with?('five') then
    tens << 5
  elsif line.start_with?('six') then
    tens << 6
  elsif line.start_with?('seven') then
    tens << 7
  elsif line.start_with?('eight') then
    tens << 8
  elsif line.start_with?('nine') then
    tens << 9
  end  
end

lines.each do |line|
  line = line[line.rindex(/\d|one|two|three|four|five|six|seven|eight|nine/i)..]
  if line.start_with?(/\d/) then
    units << line[0].to_i
  elsif line.start_with?('one') then
    units << 1
  elsif line.start_with?('two') then
    units << 2
  elsif line.start_with?('three') then
    units << 3
  elsif line.start_with?('four') then
    units << 4
  elsif line.start_with?('five') then
    units << 5
  elsif line.start_with?('six') then
    units << 6
  elsif line.start_with?('seven') then
    units << 7
  elsif line.start_with?('eight') then
    units << 8
  elsif line.start_with?('nine') then
    units << 9
  end  
end

nums = []
(0...lines.size).each do |index|
  nums << tens[index] * 10 + units[index]
end

p nums.sum
