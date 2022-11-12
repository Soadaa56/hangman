# game.rb

require_relative './display'
require 'pry-byebug'

class Game
  attr_accessor :word, :available_letters, :solved_letter, :incorrect_letters
  include Display

  def initialize
    @available_letters = ('a'..'z').to_a
    @solved_letter = Array.new
    @incorrect_letters = Array.new
    start_game
  end

  def start_game
    puts display_instructions
    new_game
  end

  def new_game
    @word = generate_word
    p @word
  end

  def generate_word
    file = File.open('google-10000-english-no-swears.txt', 'r')
    dictionary = file.readlines.map(&:chomp)
    word = dictionary[(rand*10000).round]
    if word.length >= 5 && word.length <= 12
      word
    else
      generate_word
    end
    file.close
  end


end

# playtesting purposes, will be moved to ./hangman.rb
a = Game.new