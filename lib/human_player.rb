# frozen_string_literal: true

require 'player'

# Human Player Object
class HumanPlayer < Player
  # Start human player's turn
  def start_turn
    @dealer.players.each do |player|
      print "#{player.name}: #{player.cards.count} cards  "
    end
    print "\n\n"
    i = 0
    print 'Select card:  '
    cards.each do |card|
      print "#{i}:#{card}"
    end
  end
end
