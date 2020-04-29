# frozen_string_literal: true

# Bank
class Bank
  attr_reader :bank

  BET = 10
  START_BANK = 100

  def initialize
    @bank = START_BANK
  end

  def make_bet
    @bank -= BET
  end

  def win
    @bank += 2 * BET
  end

  def tie
    @bank += 10
  end

  def bet
    BET
  end
end
