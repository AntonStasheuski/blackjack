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
    player, dealer = start_information
    loop do
      enough_money?(player, dealer)
      game = game_start(player, dealer)
      loop do
        puts "Ваши очки: #{game.player.score}"
        see_hand(game.player.hand)
        player_turn(game)
        dealer_turn(game) unless game.completed?
        next unless game.completed?

        winner = game.winner
        if winner.nil?
          tie(game)
        elsif winner.type == 'dealer'
          win(game, winner) { 'Вы проиграли диллеру с картми: ' }
        elsif winner.type == 'player'
          win(game, winner) { 'Вы победили диллера с картми: ' }
        end
        play_again?
        break
      end
    end
  end

  protected

  def play_again?
    choice = select_information { 'Хотите сыграть еще? 1 - да, 2 - нет' }
    exit if choice != 1
  end

  def tie(game)
    puts 'Ничья, у вас одинаковое кол-во очков'
    print 'Карты диллера: '
    see_hand(game.dealer.hand)
    game.player.bank.tie
    game.dealer.bank.tie
  end

  def win(game, winner)
    print yield
    see_hand(game.dealer.hand)
    winner.bank.win
  end

  def dealer_turn(game)
    score = game.dealer.score
    draw_cards(1, game.dealer, game.deck) unless score >= 17
  end

  def start_information
    name = select_information(nil, 'name') { 'Введите ваше имя' }
    player = Player.new(name)
    dealer = Dealer.new
    puts "#{player.name}, добро пожаловать в игру"
    puts "Вашего диллера зовут #{dealer.name}"
    puts "Размер вашего начального банка: #{player.bank.bank}"
    puts "Размер ставки: #{player.bank.bet}"
    [player, dealer]
  end

  def game_start(player, dealer)
    deck = Deck.new.generate_deck
    player.cards = []
    dealer.cards = []
    player.bet
    dealer.bet
    game = Game.new(player, dealer, deck)
    draw_cards(2, player, deck)
    draw_cards(2, dealer, deck)
    game
  end

  def player_turn(game)
    choice = select_information { "\n1 - пропуск хода, 2 - добавить карту, 3 - открыть карты" }
    if choice == 2
      draw_cards(1, game.player, game.deck)
    elsif choice == 3
      game.winner
    end
  end

  def see_hand(hand)
    hand.each { |card| print "| #{card} " }
    puts '|'
  end

  def draw_cards(count, player, deck)
    count.times { player.draw_card(deck) }
  end

  def enough_money?(player, dealer)
    player_bank = player.bank.bank
    dealer_bank = dealer.bank.bank
    puts "\n\n\nВаш банк: #{player_bank}, диллера : #{dealer_bank}"
    if !player_bank.positive?
      puts 'У вас закончились деньги, приходите еще)'
      exit
    elsif !dealer_bank.positive?
      puts 'У диллера закончились деньги, проваливайте!'
      exit
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
