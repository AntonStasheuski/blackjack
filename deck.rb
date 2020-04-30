# frozen_string_literal: true

require_relative 'card'

# Deck
class Deck
  def generate_deck
    @deck = []
    Card::CARD_SUITS.each do |suit|
      Card::CARD_VALUES.each do |value|
        @deck << Card.new(value, suit)
      end
    end
    @deck.shuffle!
  end

  protected

  attr_accessor :deck
end
