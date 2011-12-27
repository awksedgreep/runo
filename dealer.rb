#!/usr/bin/env ruby

require 'player'
require 'deck'

# to play
# game = Dealer.new('Mark', 'Wesley', 'Josh', 'Mingjia')

class Dealer
  attr_accessor :deck, :players, :direction, :turn, :current_player
  attr_accessor :total_players, :total_points, :game_start, :game_finish
  
  def initialize(*players)
    @game_start = Time.now
    @winner = false
    @deck = Deck.new(players.length / 8)
    @deck.shuffle
    @direction = 1 # start with forward direction
    @direction_name = 'Forward'
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
    @top_card = @deck.draw_card
    @total_players = @players.length
    @current_player = 0
    @player = @players[@current_player]
    # if reverse or skip handle first card
    change_direction if @top_card.internal_value == 10 # 10 = Reverse
    increment_player if @top_card.internal_value == 11 # 11 = Skip
    # if wild card have first player pick color
    @top_card.color = @player.preferred_color if @top_card.color == 4
    while !@winner
      if @top_card.penalized.nil?
        if @top_card.internal_value == 14 # Draw Four
          puts "Player #{@player.name.red.bold} drawing 4 cards"
          @player.draw_card(4)
          @top_card.penalized = true
          increment_player
        elsif @top_card.internal_value == 12 # Draw Two
          puts "Player #{@player.name.red.bold} drawing 2 cards"
          @player.draw_card(2)
          @top_card.penalized = true
          increment_player
        end
      end
      puts "It's #{(@player.name + "'s").red.bold} Turn: Direction = " + @direction_name.blue.bold
      puts "Before turn:"
      puts @player.to_s
      puts "Top card #{@top_card.to_s}"
      lay_down = @player.play_card(@top_card)
      @top_card = lay_down unless lay_down.nil?
      puts "Player #{@player.name.red.bold} played #{lay_down.to_s}" unless lay_down.nil?
      puts "Player #{@player.name.red.bold} could not lay down" if lay_down.nil?
      puts "Player #{@player.name.red.bold} now has #{@player.cards.length} cards"
      puts "After turn:"
      puts @player.to_s
      if @player.cards.length == 0
        winner
        break
      end
      if @deck.length <= 3
        puts "Reshuffling deck"
        @deck = Deck.new(@players.length / 8)
        @deck.shuffle
      end
      if @top_card.penalized.nil?
        if @top_card.internal_value == 10 # Reverse
          change_direction
          @top_card.penalized = true
        elsif @top_card.internal_value == 11 # Skip
          increment_player
          @top_card.penalized = true
        end
      end
      increment_player
    end
  end
  
  def draw_card
    @deck.draw_card
  end
  
  def increment_player
    @current_player = @current_player + @direction
    @current_player = (@total_players - 1) if @current_player < 0
    @current_player = 0 if @current_player >= @total_players
    @player = @players[@current_player]
    @current_player
  end
  
  def change_direction
    puts "Reversing Direction"
    if @direction == 1
      @direction = -1
      @direction_name = 'Reverse'
    else
      @direction = 1
      @direction_name = 'Forward'
    end
  end
  
  def points
    @total_points = 0
    @players.collect {|player| @total_points += player.points }
    @total_points
  end
  
  def winner
    puts "Player #{@player.name} Won!".red.bold
    @players.each do |player|
      puts "Player " + player.name.red.bold + " had " + player.points.to_s + " points."
    end
    puts "Total Points: " + points.to_s
    @winner = true
    @game_end = Time.now
    puts "Game took " + (@game_end - @game_start).to_s + " seconds."
  end
end
