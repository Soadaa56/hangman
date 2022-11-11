#hangman.rb
file = File.open('google-10000-english-no-swears.txt')
@word_list = file.readlines.map(&:chomp)

def random_word
  word = @word_list[(rand*10000).round]
  if word.length >= 5 && word.length <= 12
    word
  else
    random_word
  end
end

puts random_word


file.close