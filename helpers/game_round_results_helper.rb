# frozen_string_literal: true

require_relative '../config/app_settings.rb'

# Helper for Game class: calculate and display game result
module GameRoundResultsHelper
  protected

  def round_results
    if no_winners?
      return_bets
    elsif player_loss?
      @bank_sum -= @dealer.take_money(@bank_sum)
    else
      player_win? && @bank_sum -= @player.take_money(@bank_sum)
    end
  end

  def no_winners?
    if @player.too_much_score? && @dealer.too_much_score?
      @view.show("У всех перебор ( > #{AppSettings::LIMIT_SCORE})"\
                  "\nНичия")
      true
    elsif @player.score == @dealer.score
      @view.show("#{@player.name}! Одинаковое кол-во очков"\
                 " (#{@player.score} = #{@dealer.score})"\
                 "\nНичия")
      true
    end
  end

  def player_loss?
    if @player.too_much_score?
      @view.message("#{@player.name}! У вас перебор"\
                    " (#{@player.score} > #{AppSettings::LIMIT_SCORE})"\
                    "\nВы проиграли!")
      true
    elsif @player.score < @dealer.score
      @view.message("#{@player.name}! У вас меньше очков"\
                    " (#{@player.score} < #{@dealer.score})\nВы проиграли!")
      true
    end
  end

  def player_win?
    @view.message("#{@player.name}! У вас больше очков"\
                  " (#{@player.score} > #{@dealer.score})"\
                  "\nВы ВЫИГРАЛИ!!!"\
                  "\nВаш выигрыш составил #{@bank_sum} руб.")
    true
  end
end
