###
### input
###

input = File.read("input.txt")
input = input.split("\n\n").map { |pp| pp.split(/[\n ]/) }

passports = []
input.each do |pp|
  passport = {}
  pp.each do |pair|
    key, value = pair.split(':')
    passport[key] = value
  end
  passports << passport
end

passports.each do |passport|
  passport["byr"] = passport["byr"].to_i if passport.has_key?("byr")
  passport["iyr"] = passport["iyr"].to_i if passport.has_key?("iyr")
  passport["eyr"] = passport["eyr"].to_i if passport.has_key?("eyr")
end

###
### part 1
###

count = 0
passports.each do |passport|
  keys = passport.keys
  keys.delete("cid")
  count += 1 if keys.uniq.size == 7
end
puts count

###
### part 2
###

def valid?(passport)
  keys = passport.keys
  keys.delete("cid")
  return false unless keys.uniq.size == 7

  if passport.has_key?("byr")
    byr = passport["byr"]
    return false unless byr >= 1920 && byr <= 2002
  end

  if passport.has_key?("iyr")
    iyr = passport["iyr"]
    return false unless iyr >= 2010 && iyr <= 2020
  end

  if passport.has_key?("eyr")
    eyr = passport["eyr"]
    return false unless eyr >= 2020 && eyr <= 2030
  end

  if passport.has_key?("hgt")
    hgt = passport["hgt"].to_i; hgtu = passport["hgt"][-2..]
    return false unless ((hgtu == "cm" && hgt >= 150 && hgt <= 193) ||
                          (hgtu == "in" && hgt >= 59 && hgt <= 76))
  end

  if passport.has_key?("hcl")
    hcl = passport["hcl"]
    return false unless hcl =~ /^#[0-9a-f]{6}$/
  end

  if passport.has_key?("ecl")
    ecl = passport["ecl"]
    return false unless %w(amb blu brn gry grn hzl oth).include?(ecl)
  end

  if passport.has_key?("pid")
    pid = passport["pid"]
    return false unless pid =~ /^[0-9]{9}$/
  end

  true
end

puts passports.count { |passport| valid?(passport) }
