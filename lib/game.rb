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
    # future methods to be placed
    # Start new game on 1
    # Load saved game on 2
  end

  def new_game
    @word = generate_word.downcase.split('')
    # puts '_' into seperate indices of equal length to random word into an array @solved_letters
    @word.each { @solved_letters << '_'}
    puts display_word_length
    puts display_player_option_inputs
    player_turn
  end

  def generate_word
    dictionary = File.open('google-10000-english-no-swears.txt', 'r').readlines
    @valid_words = []
    dictionary.each do |word|
      @valid_words << word.strip!
    end
    # 5-12 letters helps to make the game neither too hard or too easy.
    @valid_words = @valid_words.each.select { |word| word.length.between?(5,12) }
    @valid_words[rand(0..@valid_words.length)]
  end

  def player_turn
    puts display_guesses_left
    player_input
  end

  def player_input
    puts display_incomplete_word
    puts display_ask_for_player_input
    binding.pry
    input = gets.chomp.downcase
    case input
    when 'help'
      puts display_player_option_inputs
      player_input
    when 'save'
      # comment here as reminder to change this text when save is added
      # will be changed to a display_save_game method
      puts 'This feature is not yet implemented'
      player_input
    when 'letters'
      puts display_available_letters
      player_input
    when 'exit', 'quit'
      # Still considering a 'are you sure you want to quit' method
      display_quit_game
      exit(true)
    when *@available_letters
      turn_update
    else
      puts display_case_input_else_statement
      player_input
    end
  end

  def turn_update
    #
    puts 'testing'
  end

end

# playtesting purposes, will be moved to ./hangman.rb
Game.new