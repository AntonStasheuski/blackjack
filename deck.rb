# frozen_string_literal: true

require_relative 'card'

# Deck
class Deck
  CARD_SUITS = %w[+ <3 ^ <>].freeze
  CARD_VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  def generate_deck
    @deck = []
    CARD_SUITS.each do |suit|
      CARD_VALUES.each do |value|
        @deck << Card.new(value, suit)
      end
    end
    @deck.shuffle!
  end

  protected

  attr_accessor :deck
end
