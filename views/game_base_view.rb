# frozen_string_literal: true

require_relative '../config/app_settings.rb'

# Base class for application views
class GameBaseView
  def welcome_to_game
    title
    puts 'Добро пожаловать в игру!'
    sleep_short
  end

  def end_game
    title
    puts 'До новых встреч!'
    sleep_long
    clear_console
  end

  def error(message)
    puts message
    sleep_long
  end

  def message(message)
    puts message
    sleep_short
  end

  def show(*args)
    args.each { |value| puts value }
  end

  def wait_key(message = nil)
    puts
    puts message || 'Нажмите [Enter]'
    gets
  end

  def yes?(message)
    res = nil
    loop do
      clear_console
      title
      show(message, '1. Да', '2. Нет')
      key = gets.chomp.strip.downcase
      res = check_yes_key(key)
      break if res
    end
    res == :yes
  end

  protected

  def clear_console
    system('cls') || system('clear') || puts('\e[H\e[2J')
    ''
  end

  def sleep_short
    sleep(AppSettings::SLEEP_SHORT)
  end

  def sleep_long
    sleep(AppSettings::SLEEP_LONG)
  end

  def title
    clear_console
    puts 'Игра BLACK JACK'
    puts '---------------'
  end

  def check_yes_key(key)
    if ['1', 'да', 'д', 'y', ''].include?(key)
      :yes
    elsif %w[2 нет н n].include?(key)
      :no
    else
      error('Неверный ввод')
    end
  end
end
