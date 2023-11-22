### parts 1 & 2

seq = "1113122113"

50.times do
  next_seq = ""
  grps = seq.chars.slice_when { |a, b| a != b }.to_a
  grps.each do |grp|
    next_seq << grp.size.to_s << grp.first
  end
  seq = next_seq
end

p seq.length
