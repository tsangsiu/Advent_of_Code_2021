### input

input = File.read("input_test.txt").split("\n")
input = File.read("input.txt").split("\n")

seed_to_soil_index = input.index("seed-to-soil map:")
soil_to_fert_index = input.index("soil-to-fertilizer map:")
fert_to_water_index = input.index("fertilizer-to-water map:")
water_to_light_index = input.index("water-to-light map:")
light_to_temp_index = input.index("light-to-temperature map:")
temp_to_humid_index = input.index("temperature-to-humidity map:")
humidity_to_location_index = input.index("humidity-to-location map:")

indices = [
  seed_to_soil_index,
  soil_to_fert_index,
  fert_to_water_index,
  water_to_light_index,
  light_to_temp_index,
  temp_to_humid_index,
  humidity_to_location_index,
  input.size + 1
]

seed_to_soil_map = []
soil_to_fert_map = []
fert_to_water_map = []
water_to_light_map = []
light_to_temp_map = []
temp_to_humid_map = []
humidity_to_location_map = []

maps = [
  seed_to_soil_map,
  soil_to_fert_map,
  fert_to_water_map,
  water_to_light_map,
  light_to_temp_map,
  temp_to_humid_map,
  humidity_to_location_map
]

(0..6).each do |map_index|
  input[(indices[map_index] + 1)...(indices[map_index + 1] - 1)].each do |map|
    dest, source, range = map.split.map(&:to_i)
    maps[map_index] << [source...(source + range), dest...(dest + range)]
  end
end

### part 1

seeds = input[0].gsub(/[^\d ]/,'').split.map(&:to_i)

locations = []
seeds.each do |seed|  # for each seed
  maps.each do |map|  # for each map
    map.each do |range| # for each range
      source_range, dest_range = range
      if source_range.cover?(seed)
        seed = dest_range.first + (seed - source_range.first)
        break
      end
    end
  end
  locations << seed
end

p locations.min

### part 2

new_seeds = []
index = 1
while index < seeds.size
  start_seed = seeds[index - 1]
  range = seeds[index]
  new_seeds << (start_seed...(start_seed + range))
  index += 2
end

# go in reverse, from location to seed
location = 0
loop do
  temp = location
  maps.reverse.each do |map|
    map.each do |range|
      dest_range, source_range = range
      if source_range.cover?(temp)
        temp = dest_range.first + (temp - source_range.first)
        break
      end
    end
  end
  break if new_seeds.any? { |range| range.include?(temp) }
  location += 1
end

puts location
