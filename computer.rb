# frozen_string_literal: true

require_relative 'player'

# creates a computer player
class Computer < Player
  attr_accessor :name
  def initialize
    super 'Computer'
  end

  def winning_message
    puts '', 'Sorry, computer wins this time!'
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

  def crack_code(feedback)
    p feedback
    code = []
    4.times do
      code.push(rand(1...7).to_s)
    end
    sleep 1
    code = modify_code(code, feedback)
    code.join('')
  end

  private

  def modify_code(code, feedback)
    code.each_with_index do |_, index|
      if feedback[index]
        code[index] = feedback[index][1].to_s if feedback[index][0] == 1
      end
    end
    code
  end
end
