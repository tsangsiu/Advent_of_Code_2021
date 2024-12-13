# Input

input = File.read("input.txt")
prizes = input.split("\n\n").map { |line| line.split("\n") }

prizes = prizes.map do |prize|
  a_x = prize[0][(prize[0].index("X+")+2)...(prize[0].index(", "))].to_i
  a_y = prize[0][(prize[0].index("Y+")+2)..].to_i

  b_x = prize[1][(prize[1].index("X+")+2)...(prize[1].index(", "))].to_i
  b_y = prize[1][(prize[1].index("Y+")+2)..].to_i

  pos_x = prize[2][(prize[2].index("X=")+2)...(prize[2].index(", "))].to_i
  pos_y = prize[2][(prize[2].index("Y=")+2)..].to_i

  { a_x: a_x, a_y: a_y, b_x: b_x, b_y: b_y, pos_x: pos_x, pos_y: pos_y }
end

TOKEN_A = 3
TOKEN_B = 1

# Part 1

min_tokens = 0
prizes.each do |prize|
  a = (prize[:b_y] * prize[:pos_x] - prize[:b_x] * prize[:pos_y]).to_f / (prize[:a_x] * prize[:b_y] - prize[:a_y] * prize[:b_x])
  b = (-prize[:a_y] * prize[:pos_x] + prize[:a_x] * prize[:pos_y]).to_f / (prize[:a_x] * prize[:b_y] - prize[:a_y] * prize[:b_x])
  min_tokens += (a * TOKEN_A + b * TOKEN_B).to_i if a.to_i == a && b.to_i == b
end

puts min_tokens

# Part 2

prizes = prizes.map do |prize|
  prize[:pos_x] += 10000000000000
  prize[:pos_y] += 10000000000000
  prize
end

min_tokens = 0
prizes.each do |prize|
  a = (prize[:b_y] * prize[:pos_x] - prize[:b_x] * prize[:pos_y]).to_f / (prize[:a_x] * prize[:b_y] - prize[:a_y] * prize[:b_x])
  b = (-prize[:a_y] * prize[:pos_x] + prize[:a_x] * prize[:pos_y]).to_f / (prize[:a_x] * prize[:b_y] - prize[:a_y] * prize[:b_x])
  min_tokens += (a * TOKEN_A + b * TOKEN_B).to_i if a.to_i == a && b.to_i == b
end

puts min_tokens
