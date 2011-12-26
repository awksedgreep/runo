#!/usr/bin/env ruby

require 'player'
require 'deck'

class Dealer
  attr_accessor :deck, :players
  
  def initialize(players)
    @winner = false
    @deck = Deck.new(players.length / 8)
    @deck.shuffle
    puts "Shuffling Deck: #{@deck.length} cards"
    @players = []
    players.each do |player|
      @players << Player.new(player, self)
    end
    puts "Dealing Cards"
    (1..7).each do
      @players.each do |player|
        player.draw_card
      end
    end
    @discard = []
    @discard << @deck.draw_card
    # if wild card have first player pick color
    @discard.first.color = @players.first.preferred_color if @discard.first.color == 4
    while !@winner
      @players.each do |player|
        puts "Top card #{@discard.last.to_s}"
        lay_down = player.play_card(@discard.last)
        @discard << lay_down unless lay_down.nil?
        puts "Player #{player.name} played #{@discard.last.to_s}" unless lay_down.nil?
        puts "Player #{player.name} could not lay down" if lay_down.nil?
        puts "Player #{player.name} now has #{player.cards.length} cards"
        if player.cards.length == 0
          winner(player)
          break
        end
        if @deck.length <= 3
          puts "Reshuffling deck"
          @deck = Deck.new(@players.length / 8)
          @deck.shuffle
        end
      end
    end
  end
  
  def draw_card
    @deck.draw_card
  end
  
  def winner(player)
    puts "Player #{player.name} Won!"
    @winner = true
  end
end
