# Input

input = File.read("input.txt")
secret_numbers = input.split("\n").map(&:to_i)

MODULO = 16777216

# Part 1

sum = 0
secret_numbers.each do |secret_number|
  2000.times do
    secret_number = ((secret_number * 64) ^ secret_number) % MODULO
    secret_number = ((secret_number / 32) ^ secret_number) % MODULO
    secret_number = ((secret_number * 2048) ^ secret_number) % MODULO
  end
  sum += secret_number
end

puts sum

# Part 2

prices = []
changes = []

secret_numbers.each do |secret_number|
  prices << [secret_number % 10]
  changes << [nil]

  (1..2000).each do |time|
    secret_number = ((secret_number * 64) ^ secret_number) % MODULO
    secret_number = ((secret_number / 32) ^ secret_number) % MODULO
    secret_number = ((secret_number * 2048) ^ secret_number) % MODULO

    prices.last << secret_number % 10
    changes.last << prices.last[time] - prices.last[time - 1]
  end  
end

bananas = []
change_seqs = ((-9..9).to_a * 4).permutation(4).to_a.uniq.select do |seq|
   (seq[0..1]).sum.abs < 10 &&
   (seq[1..2]).sum.abs < 10 &&
   (seq[2..3]).sum.abs < 10 &&
   (seq[0..2]).sum.abs < 10 &&
   (seq[1..3]).sum.abs < 10 &&
   (seq[0..3]).sum.abs < 10
end
change_seqs.each do |change_seq|
  p change_seq
  bananas << []
  changes.each_with_index do |change, changes_idx|
    (1...(change.size - 4)).each do |change_idx|
      if change[change_idx...(change_idx + 4)] == change_seq
        bananas.last << prices[changes_idx][change_idx + 3]
        break
      end
    end

  end
end

puts bananas.map { |bananas| bananas.sum }.max
