#hangman.rb
# puts "Lets play a game of Hangman!"

file = File.open('google-10000-english-no-swears.txt')
word_list = file.readlines.map(&:chomp)
puts word_list[9]


file.close