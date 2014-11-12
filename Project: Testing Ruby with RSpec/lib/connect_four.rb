class Table
  attr_reader :max_playes
  
  def initialize
    @length = 7
    @height = 6
    @max_playes = @length * @height
    @fields = Array.new(@max_playes, ' empty ')
  end
  
  def pin(color, x, y)
    check_coords(x, y)
    if @fields[coords_to_index(x,y)] == ' empty '
      @fields[coords_to_index(x,y)] = color.rjust(7)
    else
      raise "Field is occupied"
    end
  end

  def game_over?(color, x, y)
    row = four_in_a_row?(color, get_row(y))
    col = four_in_a_row?(color, get_column(x))
    d1  = four_in_a_row?(color, get_left_diagonal([x,y]))
    d2  = four_in_a_row?(color, get_right_diagonal([x,y]))
    row || col || d1 || d2
  end

  def to_s
    separator = "\n#{'-' * 70}\n"
    (0...@height).map do |i|
      @fields[(@length * i)...(@length * (i+1))].join(" | ")
    end.reverse.join(separator)
  end
  
  private
  def get_row(row)
    @fields[(@length*row)...(@length*(row + 1))]
  end

  def get_column(col)
    @fields.select.with_index { |_,i| i % @length == col } 
  end

  def get_left_diagonal(diagonal)
    # if it's point ([x,y]) turn it to diagonal with just one point ([ [x,y] ])
    if !diagonal[0].instance_of? Array
      get_left_diagonal([diagonal])
    elsif diagonal[0][0] > 0 && diagonal[0][1] > 0
      get_left_diagonal([ diagonal[0][0]-1, diagonal[0][1]-1 ] + diagonal)
    elsif diagonal[-1][0] < @length-1 && diagonal[-1][1] < @height-1
      get_left_diagonal(diagonal << [ diagonal[-1][0]+1, diagonal[-1][1]+1 ])
    else
      diagonal.map { |pt| @fields[coords_to_index(pt[0], pt[1])] }
    end
  end

  def get_right_diagonal(diagonal)
    if !diagonal[0].instance_of? Array
      get_right_diagonal([diagonal])
    elsif diagonal[0][0] < @length-1 && diagonal[0][1] > 0
      get_right_diagonal([ diagonal[0][0]+1, diagonal[0][1]-1 ] + diagonal)
    elsif diagonal[-1][0] > 0 && diagonal[-1][1] < @height-1
      get_right_diagonal(diagonal << [ diagonal[-1][0]-1, diagonal[-1][1]+1 ])
    else
      diagonal.map { |pt| @fields[coords_to_index(pt[0], pt[1])] }
    end
  end

  def four_in_a_row?(color, arr)
    in_a_row = 0
    arr.each do | col |
      col == color ? in_a_row += 1 : in_a_row = 0
      return true if in_a_row == 4
    end
    false
  end
  
  def coords_to_index(x, y)
    x + @length * y
  end
  
  def check_coords(x, y)
    raise "Invalid length" if x > @length - 1 || x < 0
    raise "Invalid height" if y > @height - 1 || y < 0
  end
end


class Game
  def initialize
    puts "Welcome to Connect Four"
    print "Player1 choose your color: "
    @player1 = gets.chomp.upcase.ljust(7)
    print "Player2 choose your color: "
    @player2 = gets.chomp.upcase.ljust(7)
    @table = Table.new
  end

  def play(player=nil)
    @table.max_playes.times do |play|
      
      puts "\nTable:"
      puts @table
      puts
      
      if play % 2 == 0
        color = @player1
        print "#{@player1}, please pick an empty filed (x,y): "
      else
        color = @player2
        print "#{@player2}, please pick an empty field (x,y): "
      end
      x,y = gets.chomp.split(",").map { |n| n.to_i }
      @table.pin(color, x, y)

      if @table.game_over?(color, x, y)
        puts "#{color} won!"
        break
      end
    end
  end
end

# g = Game.new
# g.play
