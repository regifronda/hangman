require 'pry'
module Hangman
  class Game
    def choose_word
      words = []
      File.open("5desk.txt", "r") do |file|
        file.each_line do |line|
          words << line.delete("\n").delete("\r")
        end
      end
      words.select {|word| word.length.between?(5, 12)}.sample
    end
  end
end

include Hangman
bruh = Game.new 
