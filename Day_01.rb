require_relative "./Input/Day_01_Input.rb"

report = Input::REPORT.map { |depth| depth.to_i }

### Part 1 ###

increase_count = 0
report.each_with_index do |depth, index|
  if index > 0
    increase_count += 1 if depth > report[index - 1]
  end
end

puts increase_count # => 1564

### Part 2 ###

sums = []
increase_count = 0
2.upto(report.size - 1) do |index|
  sum = report[index - 2] + report[index - 1] + report[index]
  if sums.size > 0
    increase_count += 1 if sum > sums.last
  end
  sums << sum
end

puts increase_count
