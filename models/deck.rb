# frozen_string_literal: true

require_relative '../config/app_settings.rb'
require_relative 'card.rb'

# Deck of cards
class Deck
  attr_reader :cards

  def initialize
    @cards = []
    AppSettings::CARD_RANKS.each do |kind|
      AppSettings::CARD_SUITS.each do |suit|
        @cards << Card.new(kind[0], suit[0])
      end
    end
  end

  # Shuffle the desk
  def shuffle!
    @cards.shuffle!
  end

  # deal the count of cards from deck
  def deal_card
    @cards.pop
  end
end
