### input

# input = File.read("input_test.txt").split("\n")
input = File.read("input.txt").split("\n")

distances = {}
input.map(&:split).each do |info|
  distances[[info[0], info[2]].sort] = info[4].to_i
end

### part 1

locations = distances.keys.flatten.uniq.sort
permutations = locations.permutation.to_a
routes_distances = permutations.map do |route|
  distance = 0
  ((0...route.size)).each_cons(2) do |index_1, index_2|
    location_1 = route[index_1]
    location_2 = route[index_2]
    distance += distances[[location_1, location_2].sort]
  end
  distance
end

p routes_distances.min

### part 2

p routes_distances.max
