require 'pry'
require 'json'

module Hangman
  class Game
    attr_accessor :word, :right_guesses, :wrong_guesses

    def initialize
      @word = choose_word
      @right_guesses = Array.new(@word.length, "_")
      @wrong_guesses = Array.new
      
      @player = Player.new

      ask_to_load_game
      game_loop
    end

    def game_loop
      loop do
        
        guess = @player.ask_for_guess
      
        if check_save(guess)
          next
        end

        add_letter(guess, @word)

        puts "Secret word: #{@right_guesses.join(' _')}"
        puts "Guesses made: #{@wrong_guesses.join(', ')}"
        break if check_game_over
      end
    end

    def ask_to_load_game
      puts "Enter 'y' if you would like to load your game. Otherwise, enter any key."
      input = gets.chomp
      if input.downcase == 'y'
        load_game
      end
    end

    def load_game
      save_file = File.read("saved_game.json")
      json_hash = JSON.parse(save_file)
      @word = json_hash["word"]
      @right_guesses = json_hash["right_guesses"]
      @wrong_guesses = json_hash["wrong_guesses"]
    end

    def check_save(guess)
      if guess == "save"
        puts "You chose to save your game"
        save_game
        true
      end
    end

    def save_game
      json_object = {
        :word => @word,
        :right_guesses => @right_guesses,
        :wrong_guesses => @wrong_guesses
      }.to_json
      File.open("saved_game.json", "w") { |file| file.write(json_object) }
    end

    def check_game_over
      check_win || check_lose
    end

    def check_win
      if @right_guesses.include?("_")
        false
      else
        puts "You win!"
        true
      end
    end

    def check_lose
      if @wrong_guesses.length == 6
        puts "Reached 6 guesses! You lose! Correct word was: #{@word}"
        true
      else
        false
      end
    end

    def add_letter(guess, secret_word)
      if secret_word.include?(guess)
        @word.each_char.with_index do |letter, index|
          @right_guesses[index] = letter if guess.include?(letter.downcase)
        end
      else
        @wrong_guesses << guess
        puts "Incorrect!"
      end
    end

    def choose_word
      words = Array.new
      File.open("5desk.txt", "r") do |file|
        file.each_line do |line|
          words << line.delete("\n").delete("\r")
        end
      end
      words.select {|word| word.length.between?(5, 12)}.sample.downcase
    end
  end

  class Player
    def ask_for_guess
      puts "Enter a letter. You can enter 'save' to save your game at any time."
      guess = gets.chomp.downcase

      if guess.length == 1
        guess
      elsif guess == "save"
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