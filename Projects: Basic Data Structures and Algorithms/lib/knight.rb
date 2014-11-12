class MyQueue < Array
  def push(elem)
    self.unshift(elem)
  end
end

class Table
  def initialize
    @max_x = 7
    @max_y = 7
  end

  def is_on_table?(figure)
    figure.x <= @max_x && figure.y <= @max_y
  end
end

class Knight
  attr_reader :x, :y, :history
  def initialize(pos, h=[])
    @x = pos[0]
    @y = pos[1]
    @history = h + [ position ]
  end

  def position
    [ @x, @y ]
  end
  
  def successors
    moves = [ [@x+2, @y+1], [@x+2, @y-1], [@x-2, @y+1], [@x-2, @y-1],
              [@x+1, @y+2], [@x+1, @y-2], [@x-1, @y+2], [@x-1, @y-2] ]
    moves.map { |p| Knight.new(p, @history) }
  end
end

def knight_moves(start, finish)
  knight = Knight.new(start)
  table  = Table.new
  queue  = MyQueue.new

  queue.push(knight)

  until knight.position == finish
    knight = queue.pop
    succs  = knight.successors.select { |k| table.is_on_table?(k) }
    succs.each { |k| queue.push(k) }
  end
  knight.history
end

def display_knight_moves(start, finish)
  path = knight_moves(start, finish)
  puts "You made it in #{path.size - 1} moves! Here's your path:"
  puts path.inspect
end
