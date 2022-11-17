# Input

paths = File.readlines("Input/Day03.txt")
paths.map! { |path| path.split(",") }

paths.each do |path|
  path.map! do |step|
    [step[0], step[1..].to_i]
  end
end

# Part 1

# to get all the coordinates that the wires will pass through
path1 = [[0,0]]
paths.first.each do |path|
  direction = path.first
  nstep = path.last
  if direction == 'R' then
    (1..nstep).each { |step| path1 << [path1.last.first + 1, path1.last.last] }
  elsif direction == 'L' then
    (1..nstep).each { |step| path1 << [path1.last.first - 1, path1.last.last] }
  elsif direction == 'U' then
    (1..nstep).each { |step| path1 << [path1.last.first, path1.last.last + 1] }
  elsif direction == 'D' then
    (1..nstep).each { |step| path1 << [path1.last.first, path1.last.last - 1] }
  end
end

path2 = [[0,0]]
paths.last.each do |path|
  direction = path.first
  nstep = path.last
  if direction == 'R' then
    (1..nstep).each { |step| path2 << [path2.last.first + 1, path2.last.last] }
  elsif direction == 'L' then
    (1..nstep).each { |step| path2 << [path2.last.first - 1, path2.last.last] }
  elsif direction == 'U' then
    (1..nstep).each { |step| path2 << [path2.last.first, path2.last.last + 1] }
  elsif direction == 'D' then
    (1..nstep).each { |step| path2 << [path2.last.first, path2.last.last - 1] }
  end
end

intersection_point = path1 & path2
manhattan_dist = intersection_point.map do |path|
  path.first.abs + path.last.abs
end
p manhattan_dist.select { |dist| dist > 0 }.min

# Part 2

steps = intersection_point.map do |point|
  path1.index(point) + path2.index(point)
end
p steps.select { |step| step > 0 }.min
