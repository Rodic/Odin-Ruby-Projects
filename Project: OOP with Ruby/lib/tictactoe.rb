
class Table
  
  def initialize
    @fields = Array.new(9)
  end
  
  def set(sign, x, y)
    i = x*3 + y
    if @fields[i] == nil
      @fields[i] = sign
    else
      raise "Field already taken!"
    end
  end
  
  def get_row(i)
    @fields[(i*3..i*3+2)]
  end
  
  def get_col(j)
    [ 0, 3, 6].map { |i| @fields[i+j] }
  end

  def get_d1
    [ 0, 4, 8].map { |i| @field[i] }
  end

  def get_d2
    [ 2, 4, 6].map { |i| @field[i] }
  end
  
  def to_s
    [ 0, 1, 2].map { |i| get_row(i).to_s }.join("\n")
  end  
end


class Game

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @table = Table.new
  end

  def game_over?
    [ 0, 1, 2 ].each do |i|
      row = @table.get_row(i)
      col = @table.get_col(i)
      if [ row.count('x'), row.count('o'),
           col.count('x'), col.count('o') ].include?(3)
        return true
      end
    end
    [ get_d1.count('x'), get_d1.count('o'),
      get_d2.count('x'), get_d2.count('o') ].include(3)
  end
  
  def make_move(player)
    sign = @player1 == player ? 'x' : 'o'
    puts "#{player}, please enter coords (x,y): "
    i, j = gets.chomp.split(',').map { |x| x.to_i }
    begin
      @table.set(sign, i, j)
    rescue RuntimeError => e
      puts e
      make_move(player)
    end
  end
  
  def play
    (0..8).each do |p|
      player = p % 2 == 0 ? @player1 : @player2
      puts @table
      make_move(player)
      if game_over?
        puts "Game over! #{player} won!"
        break
      end
    end
  end
end

g = Game.new('p1', 'p2')
g.play
