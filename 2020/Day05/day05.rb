###
### input
###

passes = File.read("input.txt").split("\n")

###
### part 1
###

seat_ids = []
passes.map do |pass|
  row = (0..127).to_a; col = (0..7).to_a
  pass.chars.each_with_index do |bin, idx|
    if (0..6).include?(idx)
      if bin == "F"
        row = row[0..(row.length / 2)]
      else
        row = row[(row.length / 2)..]
      end
    else
      if bin == "L"
        col = col[0..(col.length / 2)]
      else
        col = col[(col.length / 2)..]
      end
    end
  end
  seat_ids << row[0] * 8 + col[0]
end

puts seat_ids.max

###
### part 2
###

puts (seat_ids.sort.slice_when do |a, b|
  b - a != 1
end.to_a.first.max + 1)
