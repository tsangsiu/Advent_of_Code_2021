# Input

input = File.read("input.txt")
lines = input.split("\n").map { |line| line.split.map(&:to_i) }

# Part 1

safe_report = []
unsafe_report = []

lines.each do |report|
  diffs = []
  (1...(report.size)).each do |index|
    diffs << report[index] - report[index - 1]
  end

  diffs.sort!
  if (1..3).include?(diffs.first.abs) &&
     (1..3).include?(diffs.last.abs) &&
     diffs.first * diffs.last > 0 then
    safe_report << report
  else
    unsafe_report << report
  end
end

p safe_report.size

# Part 2

count = safe_report.size

unsafe_report.each do |report|
  (0...(report.size)).each do |exclude_index|
    _report = report.clone
    _report.delete_at(exclude_index)

    diffs = []
    (1...(_report.size)).each do |index|
      diffs << _report[index] - _report[index - 1]
    end

    diffs.sort!
    if (1..3).include?(diffs.first.abs) &&
       (1..3).include?(diffs.last.abs) &&
       diffs.first * diffs.last > 0 then
      count += 1
      break
    end
  end
end

p count
