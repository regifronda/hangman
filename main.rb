require 'pry'
module Hangman
  class Game
    attr_accessor :word, :hidden_word

    def initialize
      @word = choose_word
    end

    def choose_word
      words = []
      File.open("5desk.txt", "r") do |file|
        file.each_line do |line|
          words << line.delete("\n").delete("\r")
        end
      end
      words.select {|word| word.length.between?(5, 12)}.sample.strip
    end
    def hide_word
      @hidden_word = "*" * @word.size 
    end
  end
end

include Hangman
bruh = Game.new 
puts big = bruh.choose_word
puts chungus = bruh.hide_word