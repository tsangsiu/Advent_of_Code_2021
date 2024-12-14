# Input

input = File.read("input.txt")
roborts = input.split("\n").map { |robort| robort.split }
roborts = roborts.map do |pos, vel|
  pos = pos[2..].split(',').map(&:to_i)
  vel = vel[2..].split(',').map(&:to_i)
  [pos, vel]
end

WIDE = 101
TALL = 103

# Part 1

pos = roborts.map { |robort| robort[0] }
vel = roborts.map { |robort| robort[1] }

100.times do
  pos.each_with_index do |pos, idx|
    pos[0] = (pos[0] + vel[idx][0]) % WIDE
    pos[1] = (pos[1] + vel[idx][1]) % TALL
  end
end

n_quadrants_1 = pos.count { |pos| pos[0] < WIDE / 2 && pos[1] < TALL / 2 }
n_quadrants_2 = pos.count { |pos| pos[0] > WIDE / 2 && pos[1] < TALL / 2 }
n_quadrants_3 = pos.count { |pos| pos[0] < WIDE / 2 && pos[1] > TALL / 2 }
n_quadrants_4 = pos.count { |pos| pos[0] > WIDE / 2 && pos[1] > TALL / 2 }

puts n_quadrants_1 * n_quadrants_2 * n_quadrants_3 * n_quadrants_4

# Part 2

def display(grid)
  grid.each do |line|
    puts line.join('')
  end
end

pos = roborts.map { |robort| robort[0] }
vel = roborts.map { |robort| robort[1] }

(1..(WIDE * TALL)).each do |idx|
  pos.each_with_index do |pos, idx|
    pos[0] = (pos[0] + vel[idx][0]) % WIDE
    pos[1] = (pos[1] + vel[idx][1]) % TALL
  end

  grid = []
  TALL.times do
    grid << [' '] * WIDE
  end

  pos.each do |pos|
    grid[pos[1]][pos[0]] = '#'
  end

  system("clear")
  puts idx
  display(grid)

  break if idx == 7847
end
