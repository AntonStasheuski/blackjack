# frozen_string_literal: true

require_relative 'user'
# Player
class Player < User
  def initialize(name)
    super
    @type = 'player'
  end
end
