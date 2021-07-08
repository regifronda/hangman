require 'pry'
module Hangman
  class Game
    attr_accessor :word, :right_guesses, :wrong_guesses

    def initialize
      @word = choose_word
      p @word
      @right_guesses = Array.new(@word.length, "_")
      p @right_guesses
      @wrong_guesses = Array.new
      p @wrong_guesses
      p @wrong_guesses.length

      
    end

    # game loop method

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
    attr_accessor :guess
    def initialize
      @guess = guess
    end

    def get_guess
      guess = ask_for_guess
    end

    def ask_for_guess
      puts "Enter a letter"
      gets.chomp.downcase
    end
  end
end

include Hangman
bruh = Game.new 