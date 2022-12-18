### input

input = File.read("input.txt").split("\n")

valves = input.map do |line|
  { valve: line.split[1],
    flow_rate: line.split[4][5..].to_i,
    to: line.split[9..].map { |to| to[0..1] } }
end

$flow_rates = {}
valves.each do |valve|
  $flow_rates[valve[:valve]] = valve[:flow_rate]
end

$graph = {}
valves.each do |valve|
  $graph[valve[:valve]] = valve[:to]
end

START = "AA"

### part 1

def solve(valve, time, opened)
  return 0 if time == 0

  # walk to other positions
  value = ($graph[valve].map do |valve|
    $memo[[valve, time - 1, opened.sort!]] = solve(valve, time - 1, opened.sort!) if $memo[[valve, time - 1, opened.sort!]].nil?
    $memo[[valve, time - 1, opened.sort!]]
  end).max

  # open the valve at the current position
  if $flow_rates[valve] > 0 && !opened.include?(valve)
    new_opened = opened.clone
    new_opened << valve; new_opened.sort!
    $memo[[valve, time - 1, new_opened]] = solve(valve, time - 1, new_opened) if $memo[[valve, time - 1, new_opened]].nil?
    value = [value, (time - 1) * $flow_rates[valve] + $memo[[valve, time - 1, new_opened]]].max
  end

  value
end

$memo = Hash.new(nil) # for memoization
puts solve("AA", 30, [])

### part 2

def solve(valve, time, opened, elephant = false)
  if time == 0
    return solve("AA", 26, opened) if elephant # when time == 0, let the elephant do the work again (the order doesn't matter)
    return 0
  end

  # walk to other positions
  value = ($graph[valve].map do |valve|
    $memo[[valve, time - 1, opened.sort!, elephant]] = solve(valve, time - 1, opened.sort!, elephant) if $memo[[valve, time - 1, opened.sort!, elephant]].nil?
    $memo[[valve, time - 1, opened.sort!, elephant]]
  end).max

  # open the valve at the current position
  if $flow_rates[valve] > 0 && !opened.include?(valve)
    new_opened = opened.clone
    new_opened << valve; new_opened.sort!
    $memo[[valve, time - 1, new_opened, elephant]] = solve(valve, time - 1, new_opened, elephant) if $memo[[valve, time - 1, new_opened, elephant]].nil?
    value = [value, (time - 1) * $flow_rates[valve] + $memo[[valve, time - 1, new_opened, elephant]]].max
  end

  value
end

$memo = Hash.new(nil) # for memoization
puts solve("AA", 26, [], elephant = true)
