# frozen_string_literal: true

# Game
#
require 'pry'

class Game
  WIN_SCORE = 21

  attr_accessor :player, :dealer, :deck, :completed

  def winner
    self.completed = true
    player_score = player.calculate_score
    dealer_score = dealer.calculate_score

    if player_score <= WIN_SCORE && (player_score > dealer_score || dealer_score >= WIN_SCORE)
      player
    elsif dealer_score <= WIN_SCORE && dealer_score != player_score
      dealer
    end
  end

  def dealer_turn(dealer)
    score = dealer.score
    draw_cards(1, dealer, deck) unless score >= 17
  end

  def player_turn(_game, choice)
    if choice == 2
      draw_cards(1, player, deck)
    elsif choice == 3
      winner
    elsif choice == 4
      binding.pry
    end
  end

  def win(winner)
    winner.bank.win
  end

  def tie(player, dealer)
    player.bank.tie
    dealer.bank.tie
  end

  def see_hand(hand)
    hand.map { |card| card }.join(' | ')
  end

  def completed?
    completed
  end

  def draw_cards(count, player, deck)
    count.times { player.draw_card(deck) }
  end

  def play_again?(choice)
    exit if choice != 1
  end

  def start_information(name)
    @player = Player.new(name)
    @dealer = Dealer.new
    [@player, @dealer]
  end

  def game_start
    @deck = Deck.new.generate_deck
    @completed = false
    @player.cards = []
    @dealer.cards = []
    @player.bet
    @dealer.bet
    draw_cards(2, @player, @deck)
    draw_cards(2, @dealer, @deck)
  end

  def enough_money?
    player_bank = @player.bank.bank
    dealer_bank = @dealer.bank.bank
    player_bank.positive? && dealer_bank.positive?
  end
end
