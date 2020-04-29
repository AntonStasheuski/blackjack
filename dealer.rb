# frozen_string_literal: true

require_relative 'user'
require_relative 'card'
# Dealer
class Dealer < User
  NAMES = %w[Антон Гена Вадим Максим Даник Никита].freeze

  def initialize(name = random_name)
    super
    @type = 'dealer'
  end

  def random_name
    NAMES.sample
  end
end
