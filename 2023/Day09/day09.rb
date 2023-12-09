### input

histories = File.read("input_test.txt").split("\n").map(&:split).map { |arr| arr.map(&:to_i) }
histories = File.read("input.txt").split("\n").map(&:split).map { |arr| arr.map(&:to_i) }

### part 1

extrapolated_values = []

histories.each do |history|
  seqs = [history]

  loop do
    seq = []
    (1...(seqs.last.size)).each do |index|
      seq << seqs.last[index] - seqs.last[index - 1]
    end
    seqs << seq
    break if seq.all? { |ele| ele.zero? }
  end

  # extrapolation
  seqs = seqs.reverse
  seqs.each_with_index do |seq, index|
    if index == 0
      seq << 0
    else
      seq << seqs[index - 1].last + seq.last
    end
  end

  extrapolated_values << seqs.last.last
end

puts extrapolated_values.sum

### part 2

extrapolated_values = []

histories.each do |history|
  seqs = [history]

  loop do
    seq = []
    (1...(seqs.last.size)).each do |index|
      seq << seqs.last[index] - seqs.last[index - 1]
    end
    seqs << seq
    break if seq.all? { |ele| ele.zero? }
  end

  # extrapolation
  seqs = seqs.reverse
  seqs.each_with_index do |seq, index|
    if index == 0
      seq.unshift(0)
    else
      seq.unshift(seqs[index].first - seqs[index - 1].first)
    end
  end

  extrapolated_values << seqs.last.first
end

puts extrapolated_values.sum
