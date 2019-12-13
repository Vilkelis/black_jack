# frozen_string_literal: true

require_relative '../config/app_settings.rb'

# Card class for play
class Card
  attr_reader :kind, :suit, :rank

  # kind - card kind (:act, :king, :jack, :10, :8 and e.t.c.)
  # suit - suit of card (:hearts  :clubs, :diamonds, :spades)
  # (please look at config/app_settings.rb for details)
  def initialize(kind, suit)
    @kind = kind
    @suit = suit
    @kind_info = AppSettings::CARD_RANKS[@kind]
    @suit_info = AppSettings::CARD_SUITS[@suit]
    @rank = @kind_info[:rank]
  end

  def name(show = true)
    show ? "#{@kind_info[:name]}#{@suit_info[:name]}" : '**'
  end

  def name_formated(show = true)
    "[#{name(show).center(4)}]"
  end

  def name_full
    "#{@kind_info[:name_full]}#{@suit_info[:name]}"
  end

  def name_hide
    '*'
  end
end
