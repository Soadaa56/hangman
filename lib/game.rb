# game.rb

require_relative './display'
require 'yaml'
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
    # Create a copy for my program to compare @solved_letters to @word_copy as victory condition
    # @word has letters replaced each time a correct letter is found as my solution to words with multiple same letters.
    @word_copy = @word.clone.map(&:clone)
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
      # comment here as reminder to change this text when save is added
      # will be changed to a display_save_game method
      save_game
      player_input
    when 'letters'
      puts display_available_letters
      player_input
    when 'exit', 'quit'
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

  def save_game
    output = File.new('save_game.yml', 'w')
    output.puts YAML.dump(game)
    output.close
  end
end
