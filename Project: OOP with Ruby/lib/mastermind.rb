class HumanCodebreaker
  def guess(feedback)
    print 'Please enter your guess: '
    gets.chomp.scan(/\d/).map { |i| i.to_i }
  end
end

# Variation of: http://en.wikipedia.org/wiki/Mastermind_%28board_game%29#Five-guess_algorithm
class ComputerCodebreaker
  def initialize
    a = [ 0, 1, 2, 3, 4, 5, 6, 7 ]
    @answers = a.product(a).product(a).product(a).map { |ar| ar.flatten }
    @guess   = @answers.sample
  end

  def guess(feedback)
    if feedback # if it's not the initial guess
      placed    = feedback.count "2"
      misplaced = feedback.count "1"
      @answers.select! do |code|
        _placed    = 0
        _misplaced = 0
        _code      = code.dup
        _guess     = @guess.dup
        # Find excat matches
        _guess.each_with_index do |c,i|
          if c && c == _code[i]
            _placed  += 1
            _code[i]  = nil
            _guess[i] = nil
          end
        end
        # Find misplaced matches
        _guess.each_with_index do |c,i|
          if c && j = _code.index(c)
            _misplaced += 1
            _code[j]  = nil
          end
        end
        _placed == placed && _misplaced == misplaced
      end
      @guess = @answers.sample
    end
    puts "Answer space: #{@answers.size}"
    puts "Computer guess is: #{@guess.join}"
    @guess
  end
end


class Codemaker

  def is_guess_correct?(guess_code)
    @code == guess_code
  end

  def get_feedback(codebreaker_guess)
    ans   = Array.new(4,0)
    guess = codebreaker_guess.dup
    _code = @code.dup
    # Find exact matches
    _code.each_with_index do |c,i|
      if c && c == guess[i]
        ans[i] = 2
        guess[i] = nil
        _code[i] = nil
      end
    end
    # Find misplaced matches
    _code.each_with_index do |c,i|
      if c && j = guess.index(c)
        ans[i] = 1
        guess[j] = nil
      end
    end
    ans.sort.reverse.join
  end
end


class ComputerCodemaker < Codemaker
  def initialize
    @code = get_random_code
  end

  private
  def get_random_code
    (1..4).map { |i| rand(8) }
  end
end


class HumanCodemaker < Codemaker
  def initialize(code)
    puts "Secret code is >> #{code.join} <<"
    @code = code
  end
end


class Game
  def initialize
    puts "Guess the secret code! Code conists of 4 numbers - from 0 to 7.\n\n"
    puts "Feedback code:\n" +
         "\t[2] number is where it should be\n" +
         "\t[1] number is in the code but misplaced\n" +
         "\t[0] code doesn't contain number\n\n"
    # @codemaker   = ComputerCodemaker.new
    # @codebreaker = HumanCodebreaker.new
    @codemaker   = HumanCodemaker.new (1..4).map { |i| rand(8) }
    @codebreaker = ComputerCodebreaker.new
    @attempts    = 8
  end
  
  def play
    feedback = nil # initial feedback, nothing is known
    
    (1..@attempts).each do | attempt |
      puts "\nAttempt #{attempt}/#{@attempts}"
      codebreaker_guess = @codebreaker.guess(feedback)
      if @codemaker.is_guess_correct?(codebreaker_guess)
        puts 'Codebreaker won!!'
        return
      else
        feedback = @codemaker.get_feedback(codebreaker_guess)
        puts ">> #{feedback}"
      end
    end
    puts 'Codemaker won!!'
  end
end

Game.new.play
