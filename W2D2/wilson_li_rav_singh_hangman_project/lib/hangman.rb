class Hangman
  DICTIONARY = ["sushi", "burger", "mcdonalds", "bootcamp", "pizza"]
  
  def self.random_word 
    DICTIONARY.sample
  end

  def initialize  
    @secret_word = Hangman.random_word 
    @guess_word = Array.new(@secret_word.length) {"_"}
    @attempted_chars = [] 
    @remaining_incorrect_guesses = 7

  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    arr = []
    @secret_word.each_char.with_index do |x, i| 
      if x == char 
        arr << i  
      end
    end
    arr
  end

  def fill_indices(char, arr)
    arr.each do |i|
      @guess_word[i] = char
    end
  end

  def try_guess(char) 
    if already_attempted?(char)
      print "that has already been attempted"
      return false
    else 
      @attempted_chars << char
      if get_matching_indices(char).empty?
        @remaining_incorrect_guesses -= 1
        return true 
      else 
       self.fill_indices(char, self.get_matching_indices(char))
        return true
      end
    end
  end

  def ask_user_for_guess
    puts "Enter a char:"
    char = gets.chomp
    self.try_guess(char)
  end

  def win?
    if @guess_word.join("") == @secret_word
      puts 'WIN'
      return true
    else 
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts 'LOSE'
      return true
    else 
      return false
    end
  end

  def game_over?
    if self.win? || self.lose?
      puts @secret_word
      return true
    else
      return false
    end
  end


end



