# frozen_string_literal: true

# Cards
class Card
  attr_reader :value
  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def show_card
    "#{@value}#{@suit}"
  end
end
