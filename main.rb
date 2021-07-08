require 'pry'
module Hangman
  class Game
    attr_accessor :word, :right_guesses, :wrong_guesses

    def initialize
      @word = choose_word
      @right_guesses = Array.new(@word.length, "_")
      @wrong_guesses = Array.new

      p @right_guesses
      p @wrong_guesses
      

      @player = Player.new

      game_loop
    end

    # game loop method

    def game_loop
      p @word
      guess = @player.ask_for_guess
      p guess
      
      #guess_array = Array.new
      #guess_array << guess
      #p guess_array
      
      @word.each_char.with_index do |letter, index|
        @right_guesses[index] = letter if guess.include?(letter.downcase)
      end

      p @word
      p @right_guesses

    end

    def check_lose
      if @wrong_guesses.length == 6
        "Reached 6 guesses! You lose!"
        true
      else
        false
      end
    end

    def choose_word
      words = Array.new
      File.open("5desk.txt", "r") do |file|
        file.each_line do |line|
          words << line.delete("\n").delete("\r")
        end
      end
      words.select {|word| word.length.between?(5, 12)}.sample
    end
  end

  class Player
    def ask_for_guess
      puts "Enter a letter."
      guess = gets.chomp.downcase

      if guess.length == 1
        guess
      else
        puts "Please enter only one letter."
        ask_for_guess
      end
    end
  end
end

include Hangman
bruh = Game.new 