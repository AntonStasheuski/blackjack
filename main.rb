# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'bank'
require_relative 'dealer'
require_relative 'game'
require_relative 'validation'

# Menu
class Menu
  include Validation

  def main
    game = Game.new

    name = select_information(nil, 'name') { 'Введите ваше имя' }
    player, dealer = game.start_information(name)
    puts "#{player.name}, добро пожаловать в игру"
    puts "Вашего диллера зовут #{dealer.name}"
    puts "Размер вашего начального банка: #{player.bank.bank}"
    puts "Размер ставки: #{player.bank.bet}"

    loop do
      puts "\n\n\nВаш банк: #{player.bank.bank}, диллера : #{dealer.bank.bank}"
      puts 'У кого-то из вас закончились деньги!!!' unless game.enough_money?
      game.game_start
      loop do
        puts "Ваши очки: #{game.player.score}"
        puts "Ваши карты: #{game.see_hand(player.hand)}"
        choice = select_information { "\n1 - пропуск хода, 2 - добавить карту, 3 - открыть карты" }
        game.player_turn(player, choice)
        game.dealer_turn(dealer) unless game.completed?
        next unless game.completed?

        winner ||= game.winner
        if winner.nil?
          puts 'Ничья'
          print 'Карты диллера: '
          game.tie(player, dealer)
        elsif winner.type == 'dealer'
          puts "Вы проиграли диллеру с картми: #{game.see_hand(dealer.hand)}"
          game.win(winner)
          puts "\n"
        elsif winner.type == 'player'
          puts "Вы победили диллера с картми: #{game.see_hand(dealer.hand)}"
          game.win(winner)
          puts "\n"
        end
        choice = select_information { 'Хотите сыграть еще? 1 - да, 2 - нет' }
        game.play_again?(choice)
        break
      end
    end
  end

  def select_information(_info = nil, type = 'number')
    puts yield if block_given?
    information = gets.chomp
    if type == 'number'
      validate!(info: information, type: 'number', name: :choice, length: 1, example: 2)
    elsif type == 'name'
      validate!(info: information, type: 'text', name: :name, length: -10, example: 'Антон, Гена(русские буквы и дефисы)')
    end
  end
end

Menu.new.main
