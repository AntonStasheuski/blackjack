# frozen_string_literal: true

# Score
class Score
  CARD_SIMPLE = /\d+/.freeze
  CARD_PICTURES = /[JQK]/.freeze
  ACE_CARD = /A/.freeze

  def score_calculator(cards)
    count = 0
    cards.each do |card|
      card = card.value
      count += card.scan(CARD_SIMPLE).first.to_i if card.scan(CARD_SIMPLE).any?
      count += 10 if card.scan(CARD_PICTURES).any?
      if card.scan(ACE_CARD).any? && (count + 11 <= 21)
        count += 11
      elsif card.scan(ACE_CARD).any? && (count + 11 > 21)
        count += 1
      end
    end
    count
  end
end
