### input

# input = File.read("input_test.txt").split("\n")
input = File.read("input.txt").split("\n")

input = input.map { |line| line.split(/[:,] /) }

ingredients = {}
input.each do |info|
  ingredients[info[0]] = {
    info[1].split.first => info[1].split.last.to_i,
    info[2].split.first => info[2].split.last.to_i,
    info[3].split.first => info[3].split.last.to_i,
    info[4].split.first => info[4].split.last.to_i,
    info[5].split.first => info[5].split.last.to_i,
  }
end

### part 1

info = ingredients.values

scores = []
(0..100).each do |tsp0|
  (0..100).each do |tsp1|
    (0..100).each do |tsp2|
      tsp3 = 100 - tsp0 - tsp1 - tsp2
      next if tsp3 < 0
      score = [0, info[0]["capacity"] * tsp0 + info[1]["capacity"] * tsp1 + info[2]["capacity"] * tsp2 + info[3]["capacity"] * tsp3].max *
              [0, info[0]["durability"] * tsp0 + info[1]["durability"] * tsp1 + info[2]["durability"] * tsp2 + info[3]["durability"] * tsp3].max *
              [0, info[0]["flavor"] * tsp0 + info[1]["flavor"] * tsp1 + info[2]["flavor"] * tsp2 + info[3]["flavor"] * tsp3].max *
              [0, info[0]["texture"] * tsp0 + info[1]["texture"] * tsp1 + info[2]["texture"] * tsp2 + info[3]["texture"] * tsp3].max
      scores << score
    end
  end
end

puts scores.max

### part 2

### part 1

info = ingredients.values

scores = []
(0..100).each do |tsp0|
  (0..100).each do |tsp1|
    (0..100).each do |tsp2|
      tsp3 = 100 - tsp0 - tsp1 - tsp2
      next if tsp3 < 0
      calories = [0, info[0]["calories"] * tsp0 + info[1]["calories"] * tsp1 + info[2]["calories"] * tsp2 + info[3]["calories"] * tsp3].max
      next if calories != 500
      score = [0, info[0]["capacity"] * tsp0 + info[1]["capacity"] * tsp1 + info[2]["capacity"] * tsp2 + info[3]["capacity"] * tsp3].max *
              [0, info[0]["durability"] * tsp0 + info[1]["durability"] * tsp1 + info[2]["durability"] * tsp2 + info[3]["durability"] * tsp3].max *
              [0, info[0]["flavor"] * tsp0 + info[1]["flavor"] * tsp1 + info[2]["flavor"] * tsp2 + info[3]["flavor"] * tsp3].max *
              [0, info[0]["texture"] * tsp0 + info[1]["texture"] * tsp1 + info[2]["texture"] * tsp2 + info[3]["texture"] * tsp3].max
      scores << score
    end
  end
end

puts scores.max
