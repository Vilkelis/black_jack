# frozen_string_literal: true

require_relative '../models/deck.rb'

# Helper for Game class: game round loop
module GameRoundPlayHelper
  protected

  def play_round
    start_round
    loop do
      move_action = @view.choose_move(self)
      send(move_action)
      break if finish_round?(move_action)
    end
    end_round_info
  end

  def start_round
    init_round
    bet
    init_deck
    deal_cards
  end

  def init_round
    @bank_sum = 0
    @dealer.prepare_for_round
    @player.prepare_for_round
  end

  def bet
    @bank_sum += @dealer.bet(@bet_sum)
    @bank_sum += @player.bet(@bet_sum)
  end

  def return_bets
    sum_to_return = @bank_sum.div 2
    @bank_sum -= @dealer.take_money(sum_to_return)
    @bank_sum -= @player.take_money(sum_to_return)
  end

  def init_deck
    @deck = Deck.new
    @deck.shuffle!
  end

  def deal_cards
    2.times { @player.take_card(@deck) }
    2.times { @dealer.take_card(@deck) }
  end

  def end_round_info
    @view.game_info_open_cards(self)

    round_results

    @view.display_play_sum_round_end(self)
  end
end
