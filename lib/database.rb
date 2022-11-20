# database.rb

module Database
  def save_game
    @fname = 'save_game.yml'
    File.open(@fname, 'w') { |file| file.write save_to_yaml }
  end

  def save_to_yaml
    YAML.dump(
      'word' => @word,
      'available_letters' => @available_letters,
      'solved_letters' => @solved_letters,
      'incorrect_letters' => @incorrect_letters,
      'word_copy' => @word_copy
    )
  end

  def load_game_file
    obj = YAML.load_file('./save_game.yml')
    @word = obj['word']
    @available_letters = obj['available_letters']
    @solved_letters = obj['solved_letters']
    @incorrect_letters = obj['incorrect_letters']
    @word_copy = obj['word_copy']
  end

  def load_game
    begin
      load_game_file
    rescue => exception
      puts display_no_save_file
      initialize
    else
      puts display_player_option_inputs
      puts display_word_length
      player_turn
    end
  end
end