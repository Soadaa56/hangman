# game.rb

require_relative './display'
require 'pry-byebug'

class Game
  attr_accessor :word, :available_letters, :solved_letter, :incorrect_letters
  
  include Display

  def initialize
    @available_letters = ('a'..'z').to_a
    @solved_letter = []
    @incorrect_letters = []
    start_game
  end

  def start_game
    puts display_instructions
    new_game
    # Start new game on 1
    # Load new game on 2
  end

  def new_game
    @word = generate_word
    # remove print from next line after debugging
    p @word
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

end

# playtesting purposes, will be moved to ./hangman.rb
a = Game.new