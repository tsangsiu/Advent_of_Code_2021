require 'json'

### input

packets = File.read("input.txt").split("\n\n").map{ |pair| pair.split("\n") }
packets = packets.map { |packet| packet.map { |pair| JSON.parse(pair) } }

### part 1

def right_order?(left, right)
  left.each_with_index do |element1, index|
    element2 = right[index]
    return false if element2.nil? # when left.size > right.size and can't make a decision
    if element1.class == Integer && element2.class == Integer
      next if element1 == element2
      return element1 < element2
    elsif element1.class == Array && element2.class == Array
      next if right_order?(element1, element2) == 'next'
      return right_order?(element1, element2)
    elsif element1.class == Integer && element2.class == Array
      next if right_order?([element1], element2) == 'next'
      return right_order?([element1], element2)
    elsif element1.class == Array && element2.class == Integer
      next if right_order?(element1, [element2]) == 'next'
      return right_order?(element1, [element2])
    end
  end
  return 'next' if left.size == right.size
  true # when left.size < right.size and can't make a decision
end

right_order_indices = []
packets.each_with_index do |pair, index|
  right_order_indices << (index + 1) if right_order?(pair.first, pair.last)
end

p right_order_indices.sum

### part 2

packets = packets.inject([]) do |packets, pair|
  packets << pair.first << pair.last
end

DIVIDER_PACKETS = [[[2]], [[6]]]
DIVIDER_PACKETS.each do |packet|
  packets << packet
end

packets = packets.sort do |left, right|
  right_order?(left, right) ? -1 : 1
end

p (packets.index(DIVIDER_PACKETS[0]) + 1) * (packets.index(DIVIDER_PACKETS[1]) + 1)
