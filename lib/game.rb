# game.rb

require_relative './display'
require 'pry-byebug'

class Game
  attr_accessor :word, :available_letters, :solved_letter, :incorrect_letters
  
  include Display

  def initialize
    @available_letters = ('a'..'z').to_a
    @solved_letters = []
    @incorrect_letters = []
    start_game
  end

  def start_game
    puts display_instructions
    new_game
    # Start new game on 1
    # Load saved game on 2
  end

  def new_game
    @word = generate_word.downcase.split('')
    # puts '_' into seperate indices of equal length to random word into an array @solved_letters
    @word.each { @solved_letters << '_'}
    puts display_player_option_inputs
    player_turn
  end

  def generate_word
    dictionary = File.open('google-10000-english-no-swears.txt', 'r').readlines
    @valid_words = []
    dictionary.each do |word|
      @valid_words << word.strip!
    end
    @valid_words = @valid_words.each.select { |word| word.length.between?(5,12) }
    @valid_words[rand(0..@valid_words.length)]
  end

  def player_turn
    puts display_guesses_left
    player_input
  end

  def player_input
    
  end

end

# playtesting purposes, will be moved to ./hangman.rb
Game.new