### input

# input = File.read("input_test.txt").split("\n")
input = File.read("input.txt").split("\n")

reindeers = {}
input.each do |info|
  info = info.split
  reindeers[info[0]] = { speed: info[3].to_i, duration: info[6].to_i, rest: info[13].to_i}
end

### part 1

time_elapsed = 2503

distances_travelled = reindeers.values.map do |info|
  period, remainder = time_elapsed.divmod(info[:duration] + info[:rest])
  remainder = [info[:duration], remainder].min
  period * info[:speed] * info[:duration] + remainder * info[:speed]
end

puts distances_travelled.max

### part 2

reindeers.each_value do |info|
  info[:score] = 0
  info[:distance_travelled] = 0
end

time_elapsed = 2503
(1..time_elapsed).each do |second|
  reindeers.each_value do |info|
    info[:time_elapsed] = second
    
    # to calculate the distance travelled at the current time
    period, remainder = second.divmod(info[:duration] + info[:rest])
    remainder = [info[:duration], remainder].min
    info[:distance_travelled] = period * info[:speed] * info[:duration] + remainder * info[:speed]
  end
  
  # to find the maximum distance travelled
  distances = reindeers.values.map { |info| info[:distance_travelled] }
  max_distance_travelled = distances.max

  # to adjust the score
  reindeers.each_value do |info|
    info[:score] += 1 if info[:distance_travelled] == max_distance_travelled
  end
end

puts reindeers.values.map { |info| info[:score] }.max
