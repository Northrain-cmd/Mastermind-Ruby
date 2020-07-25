# frozen_string_literal: true

# creates a human player
class Player
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  private

  def input_code
    puts 'Enter the 4 digit code (digits 1-6)', ''
    input = gets.chomp
    if input.match?(/^[1-6]{4}$/)
      input
    else
      puts 'Invalid code, please read the rules and try again'
      input_code
    end
  end

  public

  def winning_message
    puts "\n", "Congratulations! You've defeated the machine"
  end

  def create_code
    input_code.split('').map(&:to_i)
  end

  def crack_code(*)
    input_code
  end
end
