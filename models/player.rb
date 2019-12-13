# frozen_string_literal: true

require_relative '../config/app_settings.rb'

# Base class for game players
class Player
  attr_reader :cards, :name, :bank_sum

  def initialize(name, bank_sum)
    @name = name.capitalize
    @bank_sum = bank_sum
    prepare_for_round
  end

  def cards_info(show = true)
    @cards.map { |card| card.name_formated(show) }.join(' ')
  end

  def same_name?(name_to_compare)
    @name.strip.downcase == name_to_compare.strip.downcase
  end

  def prepare_for_round
    @cards = []
    @skip_move_count = 0
  end

  def can_bet?(sum)
    @bank_sum >= sum
  end

  def bet(sum)
    @bank_sum -= sum
    sum
  end

  def take_money(sum)
    @bank_sum += sum
    sum
  end

  def can_skip_move?
    @skip_move_count.zero?
  end

  def skip_move
    @skip_move_count += 1 if can_skip_move?
  end

  def can_take_card?
    @cards.count < AppSettings::PLAYER_CARD_COUNT_LIMIT
  end

  def take_card(deck)
    @cards << deck.deal_card if can_take_card?
  end

  def score
    @score = 0
    @cards.each { |card| @score += card.rank }
    correct_score
    @score
  end

  def too_much_score?
    @score > AppSettings::LIMIT_SCORE
  end

  protected

  def correct_score
    return unless @score > AppSettings::LIMIT_SCORE

    @cards.each do |card|
      if @score > AppSettings::LIMIT_SCORE && card.kind == :ace
        @score -= AppSettings::ACE_CARD_SCORE_CORRECTION
      end
    end
  end
end
