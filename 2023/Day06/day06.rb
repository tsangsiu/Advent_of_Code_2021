### input

input = File.read("input_test.txt").split("\n")
input = File.read("input.txt").split("\n")

### part 1

times = input.first.split[1..].map(&:to_i)
dists = input.last.split[1..].map(&:to_i)
n_races = times.size

n_win = []

(0...n_races).each do |race_no|
  dist_travelled = []

  (1...times[race_no]).each do |mili_sec|
    dist_travelled << mili_sec * (times[race_no] - mili_sec)
  end

  n_win << dist_travelled.select { |dist| dist > dists[race_no] }.size
end

p n_win.reduce(:*)

### part 2

times = [input.first.split[1..].join.to_i]
dists = [input.last.split[1..].join.to_i]
n_races = times.size

n_win = []

(0...n_races).each do |race_no|
  dist_travelled = []

  (1...times[race_no]).each do |mili_sec|
    dist_travelled << mili_sec * (times[race_no] - mili_sec)
  end

  n_win << dist_travelled.select { |dist| dist > dists[race_no] }.size
end

p n_win.reduce(:*)
