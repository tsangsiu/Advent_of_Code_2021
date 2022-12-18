### input

jets = File.read("inputex.txt").chomp.split('')

### class

class Tower
  attr_accessor :tower

  WIDTH = 7
  AIR = '.'

  def initialize
    @tower = [Array.new(WIDTH, AIR)]
  end

  def top_empty_row
    tower.index { |layer| layer.all? { |point| point == AIR } }
  end

  def print
    tower.reverse.map(&:join).each { |layer| puts layer }
  end

  def [](y)
    if y > tower.size - 1
      add_layer(y - tower.size + 1)
      tower[y]
    else
      tower[y]
    end
  end

  private

  def add_layer(number)
    number.times { |_| tower << Array.new(WIDTH, AIR) }
  end
end

class Rock
  FALLING_ROCK = "@"
  STOPPED_ROCK = "#"
end

class Horizontal < Rock
  attr_accessor :tower, :can_fall

  WIDTH = 4

  def initialize(tower)
    @tower = tower
    @x = 2; @y = tower.top_empty_row + 3
    draw(FALLING_ROCK)
    @can_fall = true
  end

  def left
    if @x > 0 &&
        tower[@y][@x - 1] == Tower::AIR
      clear
      @x -= 1
      draw(FALLING_ROCK)
    end
  end

  def right
    if @x + WIDTH < Tower::WIDTH &&
        tower[@y][@x + WIDTH] == Tower::AIR
      clear
      @x += 1
      draw(FALLING_ROCK)
    end
  end

  def fall
    if can_fall?
      clear
      @y -= 1
      draw(FALLING_ROCK)
    else
      @can_fall = false
      clear
      draw(STOPPED_ROCK)
    end
  end

  private

  def can_fall?
    @y > 0 && tower[@y - 1][@x, WIDTH] == [Tower::AIR] * WIDTH
  end

  def clear
    draw(Tower::AIR)
  end

  def draw(symbol)
    tower[@y][@x, WIDTH] = [symbol] * WIDTH
  end
end

class Cross < Rock
  attr_accessor :tower, :can_fall

  WIDTH = 3

  def initialize(tower)
    @tower = tower
    @x = 2; @y = tower.top_empty_row + 4
    draw(FALLING_ROCK)
    @can_fall = true
  end

  def left
    if @x > 0 &&
        tower[@y + 1][@x] == Tower::AIR &&    # ..@.
        tower[@y][@x - 1] == Tower::AIR &&    # .@@@
        tower[@y - 1][@x] == Tower::AIR       # ..@.
      clear
      @x -= 1
      draw(FALLING_ROCK)
    end
  end

  def right
    if @x + WIDTH < Tower::WIDTH &&
        tower[@y + 1][@x + WIDTH - 1] == Tower::AIR &&    # .@..
        tower[@y][@x + WIDTH] == Tower::AIR &&            # @@@.
        tower[@y - 1][@x + WIDTH - 1] == Tower::AIR       # .@..
      clear
      @x += 1
      draw(FALLING_ROCK)
    end
  end

  def fall
    if can_fall?
      clear
      @y -= 1
      draw(FALLING_ROCK)
    else
      @can_fall = false
      clear
      draw(STOPPED_ROCK)
    end
  end

  private

  def can_fall?
    @y - 2 > 0 &&
    tower[@y - 1][@x] == Tower::AIR &&        # .@.
    tower[@y - 2][@x + 1] == Tower::AIR &&    # @@@
    tower[@y - 1][@x + 2] == Tower::AIR       # .@.
  end

  def clear
    draw(Tower::AIR)
  end

  def draw(symbol)
    tower[@y + 1][@x + 1] = symbol
    tower[@y][@x, WIDTH] = [symbol] * WIDTH
    tower[@y - 1][@x + 1] = symbol
  end
end

class L < Rock
  attr_accessor :tower, :can_fall

  WIDTH = 3

  def initialize(tower)
    @tower = tower
    @x = 2; @y = tower.top_empty_row + 3
    draw(FALLING_ROCK)
    @can_fall = true
  end

  def left
    if @x > 0 &&
        tower[@y + 2][@x + 1] == Tower::AIR &&    # ...@
        tower[@y + 1][@x + 1] == Tower::AIR &&    # ...@
        tower[@y][@x - 1] == Tower::AIR           # .@@@
      clear
      @x -= 1
      draw(FALLING_ROCK)
    end
  end

  def right
    if @x + WIDTH < Tower::WIDTH &&
        tower[@y + 2][@x + WIDTH] == Tower::AIR &&    # ..@.
        tower[@y + 1][@x + WIDTH] == Tower::AIR &&    # ..@.
        tower[@y][@x + WIDTH] == Tower::AIR           # @@@.
      clear
      @x += 1
      draw(FALLING_ROCK)
    end
  end

  def fall
    if can_fall?
      clear
      @y -= 1
      draw(FALLING_ROCK)
    else
      @can_fall = false
      clear
      draw(STOPPED_ROCK)
    end
  end

  private

  def can_fall?
    @y > 0 && tower[@y - 1][@x, WIDTH] == [Tower::AIR] * WIDTH
  end

  def clear
    draw(Tower::AIR)
  end

  def draw(symbol)
    tower[@y + 2][@x + 2] = symbol
    tower[@y + 1][@x + 2] = symbol
    tower[@y][@x, WIDTH] = [symbol] * WIDTH
  end
end

class Vertical < Rock
  attr_accessor :tower, :can_fall

  WIDTH = 1

  def initialize(tower)
    @tower = tower
    @x = 2; @y = tower.top_empty_row + 3
    draw(FALLING_ROCK)
    @can_fall = true
  end

  def left
    if @x > 0 &&
        tower[@y + 3][@x - 1] == Tower::AIR &&
        tower[@y + 2][@x - 1] == Tower::AIR &&
        tower[@y + 1][@x - 1] == Tower::AIR &&
        tower[@y][@x - 1] == Tower::AIR
      clear
      @x -= 1
      draw(FALLING_ROCK)
    end
  end

  def right
    if @x + WIDTH < Tower::WIDTH &&
        tower[@y + 3][@x + 1] == Tower::AIR &&
        tower[@y + 2][@x + 1] == Tower::AIR &&
        tower[@y + 1][@x + 1] == Tower::AIR &&
        tower[@y][@x + 1] == Tower::AIR
      clear
      @x += 1
      draw(FALLING_ROCK)
    end
  end

  def fall
    if can_fall?
      clear
      @y -= 1
      draw(FALLING_ROCK)
    else
      @can_fall = false
      clear
      draw(STOPPED_ROCK)
    end
  end

  private

  def can_fall?
    @y > 0 && tower[@y - 1][@x] == Tower::AIR
  end

  def clear
    draw(Tower::AIR)
  end

  def draw(symbol)
    tower[@y + 3][@x] = symbol
    tower[@y + 2][@x] = symbol
    tower[@y + 1][@x] = symbol
    tower[@y][@x] = symbol
  end
end

class Square < Rock
  attr_accessor :tower, :can_fall

  WIDTH = 2

  def initialize(tower)
    @tower = tower
    @x = 2; @y = tower.top_empty_row + 3
    draw(FALLING_ROCK)
    @can_fall = true
  end

  def left
    if @x > 0 &&
        tower[@y + 1][@x - 1] == Tower::AIR &&
        tower[@y][@x - 1] == Tower::AIR
      clear
      @x -= 1
      draw(FALLING_ROCK)
    end
  end

  def right
    if @x + WIDTH < Tower::WIDTH &&
        tower[@y + 1][@x + WIDTH] == Tower::AIR &&
        tower[@y][@x + WIDTH] == Tower::AIR
      clear
      @x += 1
      draw(FALLING_ROCK)
    end
  end

  def fall
    if can_fall?
      clear
      @y -= 1
      draw(FALLING_ROCK)
    else
      @can_fall = false
      clear
      draw(STOPPED_ROCK)
    end
  end

  private

  def can_fall?
    @y > 0 && tower[@y - 1][@x, WIDTH] == [Tower::AIR] * WIDTH
  end

  def clear
    draw(Tower::AIR)
  end

  def draw(symbol)
    tower[@y + 1][@x, WIDTH] = [symbol] * WIDTH
    tower[@y][@x, WIDTH] = [symbol] * WIDTH
  end
end

### part 1

tower = Tower.new
index = 0

1.upto(2022) do |n|
  case n % 5
  when 1 then rock = Horizontal.new(tower)
  when 2 then rock = Cross.new(tower)
  when 3 then rock = L.new(tower)
  when 4 then rock = Vertical.new(tower)
  when 0 then rock = Square.new(tower)
  end

  until rock.can_fall == false
    jet = jets[index % jets.size]
    case jet
    when "<"
      rock.left
    when ">"
      rock.right
    end
    rock.fall

    index += 1
  end
end

p tower.top_empty_row

### part 2
