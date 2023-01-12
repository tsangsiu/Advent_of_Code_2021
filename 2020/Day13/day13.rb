###
### input
###

input = File.read("input.txt").split("\n")

###
### part 1
###

EARLIEST_TIMESTAMP = input[0].to_i
buses = input[1].split(',').reject { |element| element == "x" }.map(&:to_i)

minutes = []
id =[]
buses.each do |minute|
  mult = EARLIEST_TIMESTAMP / minute + 1
  minutes << minute * mult
  id << minute
end

earliest_bus = minutes.min
ans = (earliest_bus - EARLIEST_TIMESTAMP) * id[minutes.index(earliest_bus)]
puts ans

###
### part 2
###

buses = input[1].split(',')
offset = buses.map.with_index { |bus, idx| idx if bus =~ /\d+/ }

buses = buses.reject { |bus| bus == "x" }.map(&:to_i)
offset = offset.reject { |idx| idx.nil? }

time = 0
step = buses.first

(0..(buses.size - 2)).each do |idx|
  loop do
    time += step
    if (time + offset[idx + 1]) % buses[idx + 1] == 0
      step *= buses[idx + 1]
      break
    end
  end
end

puts time
