###
### part 1
###

list = File.read("input.txt").chomp.split("\n").map(&:to_i)
list = list.zip((0...list.size).to_a) # each pair is [number, index]

(0...list.size).each do |index|
  pair = list.select { |pair| pair[1] == index }[0]

  number = pair[0]
  current_index = list.index(pair)
  new_index = (current_index + number) % (list.size - 1)
  new_index += list.size - 1 if new_index <= 0

  list.delete(pair)
  list.insert(new_index, pair)
end
list.map! { |pair| pair[0] }

puts list[(list.index(0) + 1000) % list.size] +
      list[(list.index(0) + 2000) % list.size] +
      list[(list.index(0) + 3000) % list.size]

###
### part 2
###

KEY = 811589153

list = File.read("input.txt").chomp.split("\n").map(&:to_i).map { |num| num * KEY }
list = list.zip((0...list.size).to_a) # each pair is [number, index]

10.times do
  (0...list.size).each do |index|
    pair = list.select { |pair| pair[1] == index }[0]

    number = pair[0]
    current_index = list.index(pair)
    new_index = (current_index + number) % (list.size - 1)
    new_index += list.size - 1 if new_index <= 0

    list.delete(pair)
    list.insert(new_index, pair)
  end
end
list.map! { |pair| pair[0] }

puts list[(list.index(0) + 1000) % list.size] +
      list[(list.index(0) + 2000) % list.size] +
      list[(list.index(0) + 3000) % list.size]
