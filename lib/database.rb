# database.rb

module Database
  def save_game
    output = File.new('save_game.yml', 'w')
    output.puts YAML.dump(game)
    output.close
  end
end