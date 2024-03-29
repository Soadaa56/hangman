# game.rb

require_relative './display'
require_relative './database'
require 'yaml'

# Code for the game Hangman
class Game
  attr_accessor :word, :available_letters, :solved_letter, :incorrect_letters
  
  include Display
  include Database

  def initialize
    @available_letters = ('a'..'z').to_a
    @solved_letters = []
    @incorrect_letters = []
    @word = generate_word.downcase.split('')
    start_game
  end

  def start_game
    puts display_instructions
    puts display_input_load_game
    input_load_game
  end

  def input_load_game
    input = gets.chomp
   if input == '1'
    new_game
   elsif input == '2'
    load_game
   else
    puts display_invalid_input
    input_load_game
   end
  end

  def new_game
    # Create a copy for my program to compare @solved_letters to @word_copy as victory condition
    # @word has letters replaced each time a correct letter is found as my solution to words with multiple same letters.
    @word_copy = @word.clone.map(&:clone)
    # allows @solved_letters to have the same number of indecies to the amount @word has, so that it is displayed to the player before guessing
    @word.each { @solved_letters << '_'}
    puts display_word_length
    sleep(1)
    puts display_player_option_inputs
    player_turn
  end

  def generate_word
    dictionary = File.open('google-10000-english-no-swears.txt', 'r').readlines
    @valid_words = []
    dictionary.each do |word|
      @valid_words << word.strip!
    end
    # 5-12 letters helps to make the game neither too hard nor easy.
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
    @input = gets.chomp.downcase
    case @input
    when 'help'
      puts display_player_option_inputs
      player_input
    when 'save'
      puts display_save_game
      sleep(1)
      save_game
      exit
    when 'letters'
      puts display_available_letters
      player_input
    when 'exit', 'quit'
      puts display_quit_game
      exit(true)
    when *@available_letters
      turn_update
    else
      puts display_case_input_else_statement
      player_input
    end
  end

  def turn_update
    @available_letters.delete(@input)
    incorrect_match_letters
    correct_match_letters
    player_turn
  end

  def correct_match_letters
    # replace the matched letter and save the index of the letter so that the 
    # displayed @solved_letters shows letter in correct spot
    if @word.any?(@input)
      letter_index = @word.find_index(@input)
      @word[letter_index].replace(nil.to_s)
      @solved_letters[letter_index].replace(@input)
      if @word.any?(@input)
        correct_match_letters
      end
    end
    game_over_victory?
  end

  def incorrect_match_letters
    if !@word.any?(@input)
      @incorrect_letters << @input
      game_over_failure?
    end
  end

  def game_over_failure?
    if @incorrect_letters.length == 7
      puts display_game_over_failure
      exit
     end
  end

  def game_over_victory?
    if @solved_letters == @word_copy
      puts display_game_over_victory
      exit
    end
  end
end
