# game.rb
require 'pry-byebug'

class Game
  def initialize
    @secret_word = generate_word
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

  puts @secret_word
end