# frozen_string_literal: true

require_relative '../models/player.rb'
require_relative '../views/game_view.rb'
require_relative '../helpers/game_round_play_helper.rb'
require_relative '../helpers/game_round_action_helper.rb'
require_relative '../helpers/game_round_results_helper.rb'

# Game Black Jeck class
class Game
  include GameRoundPlayHelper
  include GameRoundActionHelper
  include GameRoundResultsHelper

  attr_reader :bank_sum, :deck, :player, :dealer, :round_no

  def initialize
    @view = GameView.new
    @view.welcome_to_game
  end

  def start(play_sum = AppSettings::PLAYER_BANK,
            bet_sum = AppSettings::PLAYER_BET)
    @play_sum = play_sum
    @bet_sum = bet_sum
    create_players
    @view.display_play_sum(self)
    play_rounds
    @view.end_game
  end

  protected

  def create_players
    @dealer = Player.new('Дилер', @play_sum)
    @player = Player.new(enter_player_name, @play_sum)
  end

  def enter_player_name
    player_name = nil
    loop do
      player_name = @view.take_player_name
      break unless @dealer.same_name?(player_name)

      @view.error("Имя игрока '#{player_name}' недопустимо")
    end
    player_name
  end

  def play_rounds
    @round_no = 1
    play_round
    while @view.play_round?(self) && can_play_round?
      @round_no += 1
      play_round
    end
  end

  def can_play_round?
    if !@player.can_bet?(@bet_sum)
      @view.player_no_money_for_play(@player)
      false
    elsif !@dealer.can_bet?(@bet_sum)
      @view.dealer_no_money_for_play(@dealer)
      false
    else
      true
    end
  end
end
