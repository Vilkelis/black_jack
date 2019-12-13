# frozen_string_literal: true

require_relative 'game_base_view.rb'

# Main view for application
class GameView < GameBaseView
  def take_player_name
    player_name = nil
    loop do
      title
      puts 'Укажите имя игрока: '
      player_name = gets.chomp.strip

      break unless player_name_empty?(player_name)
    end
    player_name
  end

  def player_name_empty?(player_name)
    return unless player_name.to_s.strip == ''

    error('Имя не указано. Повторите ввод.')
    true
  end

  def play_round?(_game)
    yes?('Будем играть еще?')
  end

  def choose_move(game)
    res = nil
    loop do
      game_info(game)
      show('Выберите действие:',
           '1. Пропустить ход', '2. Взять карту', '3. Открыть карты')
      key = gets.chomp.strip.downcase
      res = choose_move_check_key(key)
      break if res
    end
    res
  end

  def game_info(game)
    title
    show("Раунд № #{game.round_no} (банк: #{game.bank_sum} руб.)",
         '',
         "#{game.dealer.name}:",
         game.dealer.cards_info(false),
         '', '',
         "#{game.player.name} (вы):",
         game.player.cards_info,
         "oчки: #{game.player.score}", '')
  end

  def game_info_open_cards(game)
    title
    show("Раунд № #{game.round_no}",
         '',
         "#{game.dealer.name}:",
         game.dealer.cards_info,
         "oчки: #{game.dealer.score}",
         '',
         "#{game.player.name} (вы):",
         game.player.cards_info,
         "oчки: #{game.player.score}", '')
  end

  def display_play_sum(game)
    title
    puts 'Суммы на руках:'
    puts "#{game.dealer.name}: #{game.dealer.bank_sum} руб."
    puts "#{game.player.name} (вы): #{game.player.bank_sum} руб."
    wait_key
  end

  def display_play_sum_round_end(game)
    puts
    puts 'Суммы на руках по итогам раунда:'
    puts "#{game.dealer.name}: #{game.dealer.bank_sum} руб."
    puts "#{game.player.name} (вы): #{game.player.bank_sum} руб."
    wait_key
  end

  def dealer_no_money_for_play(dealer)
    puts "#{dealer.name}: Извините, у меня слишком мало денег"\
         " (#{dealer.bank_sum} руб.)."
    wait_key
  end

  def player_no_money_for_play(player)
    puts "#{player.name}! У вас слишком мало денег (#{player.bank_sum} руб.)"
    puts 'Приходите играть в следующий раз.'
    wait_key
  end

  protected

  def choose_move_check_key(key)
    if %w[1 п].include?(key)
      :skip_move
    elsif %w[2 в].include?(key)
      :take_card
    elsif %w[3 о].include?(key)
      :open_cards
    else
      error('Неверный ввод')
    end
  end
end
