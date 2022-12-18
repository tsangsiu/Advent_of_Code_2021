### input

CUBES = File.read("input.txt").chomp.split("\n").map { |coordinates| coordinates.split(',').map(&:to_i) }

### part 1

faces = []
CUBES.each_with_index do |coordinates, index|
  x, y, z = coordinates
  faces << [x - 0.5, y      , z      ]
  faces << [x      , y - 0.5, z      ]
  faces << [x      , y      , z - 0.5]
  faces << [x + 0.5, y      , z      ]
  faces << [x      , y + 0.5, z      ]
  faces << [x      , y      , z + 0.5]
end

puts faces.size - (faces.size - faces.uniq.size) * 2

### part 2

CUBES_HASH = Hash.new(false)
CUBES.each { |cube| CUBES_HASH[cube] = true }

MIN_X, MAX_X = CUBES.map { |cube| cube[0] }.minmax
MIN_Y, MAX_Y = CUBES.map { |cube| cube[1] }.minmax
MIN_Z, MAX_Z = CUBES.map { |cube| cube[2] }.minmax

def out_of_bound?(cube)
  x, y, z = cube
  x < MIN_X || x > MAX_X || y < MIN_Y || y > MAX_Y || z < MIN_Z || z > MAX_Z
end

def exterior?(cube)
  # do depth-first search for every cube to check if it's exterior by going to the very boundary
  return false if CUBES_HASH[cube]

  visited = Hash.new(false)
  stack = [cube]
  until stack.empty?
    current_cube = stack.pop
    x, y, z = current_cube

    next if visited[current_cube]
    visited[current_cube] = true

    return true if out_of_bound?(current_cube)

    stack << [x - 1, y, z] if !CUBES_HASH[[x - 1, y, z]] && !visited[[x - 1, y, z]]
    stack << [x + 1, y, z] if !CUBES_HASH[[x + 1, y, z]] && !visited[[x + 1, y, z]]
    stack << [x, y - 1, z] if !CUBES_HASH[[x, y - 1, z]] && !visited[[x, y - 1, z]]
    stack << [x, y + 1, z] if !CUBES_HASH[[x, y + 1, z]] && !visited[[x, y + 1, z]]
    stack << [x, y, z - 1] if !CUBES_HASH[[x, y, z - 1]] && !visited[[x, y, z - 1]]
    stack << [x, y, z + 1] if !CUBES_HASH[[x, y, z + 1]] && !visited[[x, y, z + 1]]
  end

  false
end

answer = 0
EXTERIOR_HASH = Hash.new(nil) # for memoization
CUBES.each_with_index do |cube, index|
  x, y, z = cube

  EXTERIOR_HASH[[x - 1, y, z]] = exterior?([x - 1, y, z]) if EXTERIOR_HASH[[x - 1, y, z]].nil?
  answer += 1 if EXTERIOR_HASH[[x - 1, y, z]]

  EXTERIOR_HASH[[x + 1, y, z]] = exterior?([x + 1, y, z]) if EXTERIOR_HASH[[x + 1, y, z]].nil?
  answer += 1 if EXTERIOR_HASH[[x + 1, y, z]]

  EXTERIOR_HASH[[x, y - 1, z]] = exterior?([x, y - 1, z]) if EXTERIOR_HASH[[x, y - 1, z]].nil?
  answer += 1 if EXTERIOR_HASH[[x, y - 1, z]]

  EXTERIOR_HASH[[x, y + 1, z]] = exterior?([x, y + 1, z]) if EXTERIOR_HASH[[x, y + 1, z]].nil?
  answer += 1 if EXTERIOR_HASH[[x, y + 1, z]]

  EXTERIOR_HASH[[x, y, z - 1]] = exterior?([x, y, z - 1]) if EXTERIOR_HASH[[x, y, z - 1]].nil?
  answer += 1 if EXTERIOR_HASH[[x, y, z - 1]]

  EXTERIOR_HASH[[x, y, z + 1]] = exterior?([x, y, z + 1]) if EXTERIOR_HASH[[x, y, z + 1]].nil?
  answer += 1 if EXTERIOR_HASH[[x, y, z + 1]]
end

puts answer
