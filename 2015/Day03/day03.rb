# input

dirs = File.read("input.txt").chars

# part 1

curr_pos = [0, 0]

houses = Hash.new(0)
houses[curr_pos.dup] += 1

dirs.each do |dir|
  if dir == '>'
    curr_pos[0] += 1
  elsif dir == '<'
    curr_pos[0] -= 1
  elsif dir == '^'
    curr_pos[1] += 1
  elsif dir == 'v'
    curr_pos[1] -= 1
  end

  houses[curr_pos.dup] += 1
end

p houses.keys.size

# part 2

curr_pos_santa = [0, 0]
curr_pos_robo = [0, 0]

houses = Hash.new(0)
houses[curr_pos_santa.dup] += 1
houses[curr_pos_robo.dup] += 1

dirs.each_with_index do |dir, index|
  if dir == '>'
    index.even? ? curr_pos_santa[0] += 1 : curr_pos_robo[0] += 1
  elsif dir == '<'
    index.even? ? curr_pos_santa[0] -= 1 : curr_pos_robo[0] -= 1
  elsif dir == '^'
    index.even? ? curr_pos_santa[1] += 1 : curr_pos_robo[1] += 1
  elsif dir == 'v'
    index.even? ? curr_pos_santa[1] -= 1 : curr_pos_robo[1] -= 1
  end

  index.even? ? houses[curr_pos_santa.dup] += 1 : houses[curr_pos_robo.dup] += 1
end

p houses.keys.size
