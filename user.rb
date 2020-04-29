# frozen_string_literal: true

require_relative 'bank'
require_relative 'score'
# User
class User
  attr_reader :name, :calculator, :bank
  attr_accessor :cards, :score, :type
  def initialize(name)
    @name = name
    @cards = []
    @bank = Bank.new
    @calculator = Score.new
  end

  def hand
    @cards.map(&:show_card)
  end

  def draw_card(deck)
    @cards << deck.shift
    calculate_score
  end

  def calculate_score
    self.score = @calculator.score_calculator(@cards)
  end

  def bet
    bank.make_bet
  end
end
