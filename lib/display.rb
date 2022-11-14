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
    <<~HEREDOC
      #{@solved_letters.join('-')}

    HEREDOC
  end

  def display_guesses_left
    <<~HEREDOC
      You have #{7 - incorrect_letters.length } lives left until game over.

    HEREDOC
  end
end