### input

input = File.read("input.txt").split("\n").map { |line| line.split(': ') }
input = input.map do |line|
  line.map do |location|
    Complex(location.split(/[ ,]/)[-3][2..].to_i, location.split(/[ ,]/)[-1][2..].to_i)
  end
end

### part 1

$sensor = Hash.new(false)
$beacon = Hash.new(false)
$no_beacon = Hash.new(false)  # contains all the points where a beacon cannot be present

input.each do |line|
  $sensor[line[0]] = true
  $beacon[line[1]] = true
end

input.each do |line|
  sensor = line[0]; beacon = line[1]
  distance = (sensor.real - beacon.real).abs + (sensor.imag - beacon.imag).abs
  (sensor.imag - distance..sensor.imag + distance).each do |y|
    next if y != 2000000
    (sensor.real - distance..sensor.real + distance).each do |x|
      if (x - sensor.real).abs + (y - sensor.imag).abs <= distance &&
          !$sensor[Complex(x, y)] &&
          !$beacon[Complex(x, y)]
        $no_beacon[Complex(x, y)] = true
      end
    end
  end
end

p $no_beacon.size

### part 2

positive_lines = []; negative_lines = []
input.each do |line|
  sensor = line[0]; beacon = line[1]
  manhattan_dist = (beacon.real - sensor.real).abs + (beacon.imag - sensor.imag).abs
  positive_lines << [-sensor.real + sensor.imag + manhattan_dist,
                      -sensor.real + sensor.imag - manhattan_dist]
  negative_lines << [sensor.real + sensor.imag + manhattan_dist,
                      sensor.real + sensor.imag - manhattan_dist]
end

positive_pairs = [] # contains pairs of positive lines which are 2 units apart
positive_lines.each_with_index do |lines, index|
  lines.each do |line|
    other_positive_lines = positive_lines[0...index] + positive_lines[index + 1..]
    other_line = other_positive_lines.flatten.select { |other_line| (line - other_line).abs == 2 }[0]
    positive_pairs << [line, other_line].sort if !other_line.nil?
  end
end
positive_pairs.uniq!

negative_pairs = [] # contains pairs of negative lines which are 2 units apart
negative_lines.each_with_index do |lines, index|
  lines.each do |line|
    other_negative_lines = negative_lines[0...index] + negative_lines[index + 1..]
    other_line = other_negative_lines.flatten.select { |other_line| (line - other_line).abs == 2 }[0]
    negative_pairs << [line, other_line].sort if !other_line.nil?
  end
end
negative_pairs.uniq!

# for the input, there is only one pair of lines that are 2 units apart
# if there are more than 1 pair, this code will break
x = (negative_pairs[0].sum / 2 - positive_pairs[0].sum / 2) / 2
y = (negative_pairs[0].sum / 2 + positive_pairs[0].sum / 2) / 2

p x * 4_000_000 + y
