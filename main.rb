require 'pry'
module Hangman
  class Game
    attr_accessor :word, :right_guesses, :wrong_guesses

    def initialize
      @word = choose_word
      p @word.length
      p @word
      @right_guesses = Array.new(@word.length, "_")
      p @right_guesses
      @wrong_guesses = Array.new
      p @wrong_guesses
    end

    def choose_word
      File.readlines("5desk.txt").sample.strip()
    end

    
  end

  class Player
  end
end

include Hangman
bruh = Game.new 