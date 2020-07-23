# frozen_string_literal: true

require_relative 'player'

# creates a computer player
class Computer < Player
  attr_accessor :name
  def initialize
    super 'Computer'
  end

  def create_code
    code = []
    4.times do
      number = 0
      loop do
        number = rand(1...7)
        break unless code.include?(number)
      end
      code.push(number)
    end
    code
  end
end
