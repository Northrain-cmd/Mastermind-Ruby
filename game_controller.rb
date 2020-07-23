# frozen_string_literal: true

require_relative 'player'
require_relative 'computer'
require 'colorize'

# controls the game logic
class GameController
  WELCOME_MESSAGE = <<~WELCOME
              Welcome to 
    ╔╦╗╔═╗╔═╗╔╦╗╔═╗╦═╗╔╦╗╦╔╗╔╔╦╗
    ║║║╠═╣╚═╗ ║ ║╣ ╠╦╝║║║║║║║ ║║
    ╩ ╩╩ ╩╚═╝ ╩ ╚═╝╩╚═╩ ╩╩╝╚╝═╩╝
    There are six different numbers:
    1   2   3   4   5   6

    The Code Maker selects four digits to create a 'Master Code'.

    There can be two or more of the same number.

    The Code Breaker needs to guess the 'Master Code' in 12 turns or less.

    Upon each guess there will be clues provided:

    #{'!'.colorize(background: :green)}    Represents a correct number, in the correct location.

    #{'!'.colorize(background: :yellow)}   Represents a correct number, but in the wrong location.

    No feedback for a number that is not part of the Master Code (which is a hint).

    START:

  WELCOME

  attr_accessor :mode, :code

  private

  def choose_mode
    input = 0
    loop do
      puts 'Press "1" to be the Code MAKER', 'Press "2" to be the Code BREAKER'
      input = gets.chomp.to_i
      break if [1, 2].include?(input)
    end
    @mode = input
  end

  def give_feedback(code)
    p @code, code
    code.chars.each_with_index do |number, index|
      if number == @code[index].to_s
        print '!'.colorize(background: :green), '  '
      elsif @code.include? number.to_i
        print '?'.colorize(background: :yellow), '  '
      end
    end
  end

  public

  def start_game
    puts WELCOME_MESSAGE
    choose_mode
    if @mode == 2
      player = Player.new('Player 1')
      computer = Computer.new
      @code = computer.create_code
      12.times do
        give_feedback(player.crack_code)
      end
    end
  end
end

controller = GameController.new
controller.start_game
