#!/usr/bin/env ruby

require 'player'
require 'deck'

class Dealer
  attr_accessor :deck, :players, :direction, :turn, :skip, :current_player, :total_players
  
  def initialize(*players)
    @winner = false
    @deck = Deck.new(players.length / 8)
    @deck.shuffle
    @direction = 1 # start with forward direction
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
    @total_players = @players.length
    @current_player = 0
    while !@winner
      #@players.each do |player|
      player = @players[@current_player]
      puts "It's #{player.name}'s Turn"
      puts "Top card #{@discard.last.to_s}"
      lay_down = player.play_card(@discard.last)
      @discard << lay_down unless lay_down.nil?
      puts "Player #{player.name} played #{lay_down.to_s}" unless lay_down.nil?
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
      unless lay_down.nil?
        @skip = true if lay_down.internal_value == 11 # 11 = Skip
        change_direction if lay_down.internal_value == 12 # 12 = Reverse
      end
      next_turn
    end
  end
  
  def draw_card
    @deck.draw_card
  end
  
  def next_turn
    if @skip
      @skip = false
      get_next_player_id
      next_turn
    else
      get_next_player_id
    end
  end
  
  def get_next_player_id
    @current_player = @current_player + @direction
    @current_player = (@total_players - 1) if @current_player < 0
    @current_player = 0 if @current_player >= @total_players
    @current_player
  end
  
  def change_direction
    @direction = 1 if @direction == -1
    @direction = -1 if @direction == 1
  end
  
  def winner(player)
    puts "Player #{player.name} Won!"
    @winner = true
  end
end
