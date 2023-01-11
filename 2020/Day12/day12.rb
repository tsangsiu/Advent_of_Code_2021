###
### input
###

instructions = File.read("input.txt").split("\n").map { |line| [line[0], line[1..].to_i] }

###
### part 1
###

pos = 0+0i
dir = 1

instructions.each do |line|
  action, num = line
  if action == "F"
    pos += num * dir
  elsif action == "L"
    dir *= 1i ** (num / 90)
  elsif action == "R"
    dir *= (-1i) ** (num / 90)
  elsif action == "N"
    pos += Complex(0, num)
  elsif action == "S"
    pos += Complex(0, -num)
  elsif action == "E"
    pos += Complex(num, 0)
  elsif action == "W"
    pos += Complex(-num, 0)
  end
end

puts pos.real.abs + pos.imag.abs

###
### part 2
###

ship = 0+0i
waypoint = 10+1i # this is relative to the ship

instructions.each do |line|
  action, num = line
  if action == "F"
    ship += waypoint * num
  elsif action == "L"
    waypoint *= 1i ** (num / 90)
  elsif action == "R"
    waypoint *= (-1i) ** (num / 90)
  elsif action == "N"
    waypoint += Complex(0, num)
  elsif action == "S"
    waypoint += Complex(0, -num)
  elsif action == "E"
    waypoint += Complex(num, 0)
  elsif action == "W"
    waypoint += Complex(-num, 0)
  end
end

puts ship.real.abs + ship.imag.abs
