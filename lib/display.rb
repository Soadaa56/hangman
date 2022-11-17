# display.rb

module Display

  def display_instructions
    <<~HEREDOC

      Instructions for Hangman:

      A random word will be chosen with a length of 5-12 letters. On each turn you will guess one letter and if the letter is a part of the random word it will be 
      shown to you. You will keep guessing letters until you find each letter of the random word or you run out of guesses (7).

    HEREDOC
  end

  def display_word_length
    <<~HEREDOC
      Your random word is #{@word.length} letters long.

    HEREDOC
  end

  def display_incomplete_word
    # figure out how to add 1-2 indents of space before displaying solved letters seperated by '-'
    <<~HEREDOC
      #{@solved_letters.join(' ')}

    HEREDOC
  end

  def display_guesses_left
    <<~HEREDOC
      You have #{7 - incorrect_letters.length } lives left until game over.

    HEREDOC
  end

  def display_player_option_inputs
    <<~HEREDOC
      Type 'help' to see these options again.
      Type 'save' at any point to save your game and return to it later.
      Type 'letters' will show you what letters you have not used yet.
      Type 'exit' will terminate the program.

    HEREDOC
  end

  def display_ask_for_player_input
    <<~HEREDOC
      Guess a single letter (case-insensitive).

    HEREDOC
  end

  def display_save_game
    <<~HEREDOC

      Saving game...

    HEREDOC
  end

  def display_available_letters
    <<~HEREDOC
      #{@available_letters}

    HEREDOC
  end

  def display_quit_game
    <<~HEREDOC
      Terminating game...
      btw, the word was
      '#{@word_copy.join()}'

    HEREDOC
  end

  def display_case_input_else_statement
    <<~HEREDOC
      I'm sorry, your input wasn't recognized. 
      Try a different letter or 'help' for more options.

    HEREDOC
  end

  def display_game_over_failure
    <<~HEREDOC

      You lost all your lives! The word was -
      '#{@word_copy.join()}'

    HEREDOC
  end

  def display_game_over_victory
    <<~HEREDOC

      Winner!!! You figured out that the word was -
      '#{@word_copy.join()}'
    
      HEREDOC
  end
end