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

    The Code Master selects four digits to create a 'Master Code'.

    There can be two or more of the same number.

    The Code Breaker needs to guess the 'Master Code' in 12 turns or less.

    Upon each guess there will be clues provided:

    #{' ! '.colorize(background: :green)}    Represents a correct number, in the correct location.

    #{' ? '.colorize(background: :yellow)}   Represents a correct number, but in the wrong location.

    No feedback for a number that is not part of the Master Code (which is a hint).

    START:

  WELCOME

  attr_accessor :mode, :code, :winner, :maker, :breaker, :feedback, :game_over

  def initialize
    @feedback = {}
    @game_over = false
  end

  private

  def choose_mode
    input = 0
    loop do
      puts 'Press "1" to be the Code MASTER', 'Press "2" to be the Code BREAKER'
      input = gets.chomp.to_i
      break if [1, 2].include?(input)

      puts 'Invalid option'
    end
    @mode = input
  end

  def show_win_msg(player)
    @game_over = true
    @winner = player
    player.winning_message
  end

  def game_cycle(player)
    12.times do
      player_guess = player.crack_code(feedback)
      give_feedback(player_guess)
      if guessed_code?(player_guess)
        show_win_msg(player)
        break
      end
    end
    puts '', 'The Code Master wins!' unless game_over
  end

  def guessed_code?(player_guess)
    player_guess == code.join
  end

  def give_feedback(code)
    p @code, code
    code.chars.each_with_index do |number, index|
      if number == @code[index].to_s
        @feedback[index] = [1, @code[index]]
        print ' ! '.colorize(background: :green), '  '
      elsif @code.include? number.to_i
        @feedback[index] = [0, @code[index]]
        print ' ? '.colorize(background: :yellow), '  '
      end
    end
  end

  def create_players
    player = Player.new('Player 1')
    @winner = player
    computer = Computer.new
    @breaker = player
    @maker = computer
    return unless @mode == 1

    @breaker = computer
    @maker = player
  end

  def new_game
    @feedback = {}
    @game_over = false
    choose_mode
    create_players
    @code = @maker.create_code
    game_cycle(@breaker)
  end

  def another_game?
    puts 'Would you like to play again? (y/n)'
    input = ''
    loop do
      input = gets.chomp
      break if %w[y n].include?(input)

      puts 'Invalid option'
    end
    input == 'y'
  end

  public

  def start_game
    puts WELCOME_MESSAGE
    choose_mode
    create_players
    @code = @maker.create_code
    game_cycle(@breaker)
    new_game while another_game?
  end
end

controller = GameController.new
controller.start_game
