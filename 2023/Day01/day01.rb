### part 1

input = File.read("input_test_1.txt").split("\n")
input = File.read("input.txt").split("\n")

numbers = []
input.each do |line|
  numbers << (line[line.index(/\d/)] + line[line.rindex(/\d/)]).to_i
end

puts numbers.sum

### part 2

input = File.read("input_test_2.txt").split("\n")
input = File.read("input.txt").split("\n")

NUMBERS = {
  "one" => 1, "two" => 2, "three" => 3, "four" => 4, "five" => 5,
  "six" => 6, "seven" => 7, "eight" => 8, "nine" => 9
}

numbers_1 = []
input.each do |line|
  (0...line.length).each do |index|
    str = line[0..index]
    next unless str =~ /(one|two|three|four|five|six|seven|eight|nine|\d)/
    if line[index] =~ /\d/
      numbers_1 << line[index].to_i 
    else
      NUMBERS.each do |word, num|
        numbers_1 << str.gsub(word, num.to_s).chars.select{ |char| char =~ /\d/ }.join.to_i if str.include?(word)
      end
    end
    break
  end
end

numbers_2 = []
input.each do |line|
  -1.downto(-line.length).each do |index|
    str = line[index..-1]
    next unless str =~ /(one|two|three|four|five|six|seven|eight|nine|\d)/
    if line[index] =~ /\d/
      numbers_2 << line[index].to_i 
    else
      NUMBERS.each do |word, num|
        numbers_2 << str.gsub(word, num.to_s).chars.select{ |char| char =~ /\d/ }.join.to_i if str.include?(word)
      end
    end
    break
  end
end

numbers = []
numbers_1.each_with_index do |num1, index|
  numbers << num1 * 10 + numbers_2[index]
end

puts numbers.sum
