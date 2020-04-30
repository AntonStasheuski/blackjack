# frozen_string_literal: true

require_relative 'bank'
require_relative 'card'
# User
class User
  attr_reader :name, :calculator, :bank
  attr_accessor :cards, :score, :type
  def initialize(name)
    @name = name
    @cards = []
    @bank = Bank.new
  end

  def hand
    @cards.map(&:face)
  end

  def draw_card(deck)
    @cards << deck.shift
    calculate_score
  end

  def calculate_score
    score = 0
    hand = @cards.sort_by { |card| card.score.size == 2 ? 1 : 0 }
    hand.each do |card|
      score += score > 11 && card.score.size == 2 ? card.score.first : card.score.last
    end
    self.score = score
  end

  def bet
    bank.make_bet
  end
end
