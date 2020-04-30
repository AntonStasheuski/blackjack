# frozen_string_literal: true

# Cards
#
require 'pry'
class Card
  CARD_SUITS = %w[+ <3 ^ <>].freeze
  CARD_VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  CARD_SIMPLE = /\d+/.freeze
  CARD_PICTURES = /[JQK]/.freeze
  ACE_CARD = /A/.freeze

  attr_reader :value, :score
  def initialize(value, suit)
    @value = value
    @suit = suit
    @score = equity
  end

  def face
    "#{@value}#{@suit}"
  end

  def equity
    return [value.scan(CARD_SIMPLE).first.to_i] if value.scan(CARD_SIMPLE).any?
    return [10] if value.scan(CARD_PICTURES).any?
    return [1, 11] if value.scan(ACE_CARD).any?
  end
end
