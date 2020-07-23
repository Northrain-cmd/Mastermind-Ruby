# frozen_string_literal: true

# creates a human player
class Player
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def crack_code
    puts 'Enter the 4 digit code (1-6)', ''
    input = gets.chomp
    if input.match?(/^[1-6]{4}$/)
      input
    else
      puts 'Invalid code, please read the rules and try again'
      crack_code
    end
  end
end
