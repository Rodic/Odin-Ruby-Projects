require 'set'
require 'yaml'

class HangmanGame

  def initialize
    @words = File.readlines('../data/5desk.txt').select  do |w|
      w.chomp.length > 4 && w.chomp.length < 13
    end
    
    @hangman = "__\n |\n"
    @parts   = [ " O", "\n-", "|", "-", "\n/",  " \\" ].reverse

    @lost = false
    @won  = false
    
    @secret_word     = select_random_word
    @correct_guesses = []
    @wrong_guesses   = []

    @save_fname = nil

    load_game
  end

  def save_game
    y = YAML::dump [ @secret_word, @correct_guesses, @wrong_guesses ]
    f = "saves/save-#{Time.now.strftime('%Y-%m-%d-%H:%M')}.yaml"
    File.open(f, "w") do |f|
      f.puts y
    end
    exit
  end

  def load_game
    print 'Load game? (y/n): '
    if gets.chomp.downcase == 'y'
      Dir.entries('saves').each do |s|
        puts "- #{s}"
      end
      print "Copy the name from above or press enter to skip load: "
      @save_fname = "saves/#{gets.chomp}"
      begin
        content = File.read(@save_fname)
        y = YAML::load(content)
        @secret_word, @correct_guesses, @wrong_guesses = y
      rescue
        return
      end
    end
  end
  
  def select_random_word
    @words.sample.chomp.downcase
  end

  def wrong_guesses
    @wrong_guesses.join(', ')
  end

  def secret_display
    @secret_word.chars.map do |l|
      @correct_guesses.include?(l) ? l : '_'
    end.join(' ')
  end
  
  def game_over?
    @lost || @won
  end

  def draw
    @hangman += @parts.pop
    @lost = @parts.empty?
  end
  
  def play    
    until game_over?
      puts '-' * 80
      puts @hangman
      puts "Secret word: #{secret_display}"
      puts "Misses: #{wrong_guesses}"

      print 'Enter your guess (or type "save" to save this game): '
      guess = gets.chomp.downcase

      if guess == 'save'
        save_game
      end

      if @secret_word.include?(guess)
        @correct_guesses << guess
        if @correct_guesses.size == Set.new(@secret_word.chars).size
          @won = true
        end
      else
        @wrong_guesses << guess
        draw
      end
    end
    puts '-' * 80
    puts @hangman
    puts @won ? "You won!" : "You lost!"
    puts "Secret word is: #{@secret_word}"
    File.delete(@save_fname) if @save_fname
  end
end

h = HangmanGame.new
h.play
