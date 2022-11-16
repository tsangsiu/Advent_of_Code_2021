# Input

modules = File.readlines("Input/Day01.txt")
modules.map! { |line| line.to_i }

# Part 1

fuel = modules.map do |mass|
  mass / 3 - 2
end
puts fuel.sum

# Part 2

fuel_array = [fuel]
until fuel_array.last.empty? do
  temp = []
  fuel_array.last.each do |mass|
    fuel = mass / 3 - 2
    temp << fuel if fuel > 0
  end
  fuel_array << temp
end
puts fuel_array.flatten.sum
