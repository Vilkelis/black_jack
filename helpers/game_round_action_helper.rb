# frozen_string_literal: true

require_relative '../config/app_settings.rb'

# Helper for Game class: Player actions
module GameRoundActionHelper
  protected

  def take_card
    if @player.can_take_card?
      @view.game_info(self)
      @view.message('Берем карту...')
      @player.take_card(@deck)
      @view.game_info(self)
      dealer_move unless finish_round?
    else
      @view.error('Вы уже не можете брать карты. Выберите другое действие.')
    end
  end

  def skip_move
    if @player.can_skip_move?
      @view.game_info(self)
      @view.message('Пропускаем ход...')
      @player.skip_move
      @view.game_info(self)
      dealer_move
    else
      @view.error('Вы уже не можете пропускать ход. Выберите другое действие.')
    end
  end

  def open_cards
    @view.game_info(self)
    @view.message('Открываем карты!')
  end

  def dealer_move
    if @dealer.can_take_card? &&
       @dealer.score < AppSettings::BOUNDARY_SCORE_FOR_AUTOMOVE
      @view.message("#{dealer.name}: беру карту...")
      @dealer.take_card(deck)
    else
      @view.message("#{dealer.name}: пропускаю ход...")
      @dealer.skip_move
    end
  end

  def finish_round?(move_action = :none)
    (!@player.can_take_card? && !@dealer.can_take_card?) ||
      move_action == :open_cards
  end
end
