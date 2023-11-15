### input

strings = File.read("input.txt").split("\n")

### part 1

count = 0

strings.each do |string|
  asciis = string.chars.map(&:ord)

  diff = []
  (1...asciis.size).each do |index|
    diff << asciis[index] - asciis[index - 1]
  end
  next unless diff.include?(0)

  next if string.include?('ab') || string.include?('cd') || string.include?('pq') || string.include?('xy')

  count += 1 if asciis.count { |ascii| [97, 101, 105, 111, 117].include?(ascii) } >= 3
end

p count

### part 2

count = 0

strings.each do |string|
  asciis = string.chars.map(&:ord)

  diff = []
  (2...asciis.size).each do |index|
    diff << asciis[index] - asciis[index - 2]
  end
  next unless diff.include?(0)

  pairs = []
  (1...string.length).each do |index|
    pair = string[index - 1, 2]
    pairs.last == pair ? pairs << nil : pairs << pair
  end
  count += 1 if pairs.uniq != pairs
end

p count
