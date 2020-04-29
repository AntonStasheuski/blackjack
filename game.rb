# frozen_string_literal: true

# Game
class Game
  WIN_SCORE = 21

  attr_accessor :player, :dealer, :deck, :completed

  def initialize(player, dealer, deck)
    @player = player
    @dealer = dealer
    @deck = deck
    @completed = false
  end

  def winner
    self.completed = true
    player_score = player.calculate_score
    dealer_score = dealer.calculate_score
    player_close_score = (WIN_SCORE - player_score).abs
    dealer_close_score = (WIN_SCORE - dealer_score).abs
    return player if player_close_score < dealer_close_score
    return dealer if player_close_score > dealer_close_score

    nil
  end

  def completed?
    completed
  end
end
