#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'player'
require_relative 'deck'
require 'logger'

# to play
# game = Dealer.new('Mark', 'Wesley', 'Josh', 'Mingjia')
class Dealer
  attr_accessor :deck, :players, :direction, :turn, :current_player, :log,
                :total_players, :total_points, :game_start, :game_finish

  def initialize(log:, players:)
    @game_start = Time.now
    @winner = false
    @deck = Deck.new(players.length / 8)
    @deck.shuffle
    @direction = 1 # start with forward direction
    @direction_name = 'Forward'
    @log = log
    @log.info { "Shuffling Deck: #{@deck.length} cards" }
    @players = []
    players.each do |player|
      @players << Player.new(log: @log, name: player, dealer: self)
    end
    @log.info { 'Dealing Cards' }
    7.times do
      @players.each(&:draw_card)
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
    until @winner
      if @top_card.penalized.nil?
        case @top_card.internal_value
        when 14 # Draw Four
          @log.info { "Player #{@player.name} drawing 4 cards" }
          @player.draw_card(4)
          @top_card.penalized = true
          increment_player
        when 12 # Draw Two
          @log.info { "Player #{@player.name} drawing 2 cards" }
          @player.draw_card(2)
          @top_card.penalized = true
          increment_player
        else
          'nothing' # Rubocop is dumb
        end
      end
      @log.info { "It's #{@player.name}'s Turn: Direction =  #{@direction_name}" }
      @log.info { "Before turn: #{@player}" }
      @log.info { "Top card #{@top_card}" }
      lay_down = @player.play_card(@top_card)
      @top_card = lay_down unless lay_down.nil?
      if lay_down.nil?
        @log.info { "Player #{@player.name} could not lay down" if lay_down.nil? }
      else
        @log.info { "Player #{@player.name} played #{lay_down}" unless lay_down.nil? }
      end
      @log.info { "Player #{@player.name} now has #{@player.cards.length} cards" }
      @log.info { "After turn: #{@player}" }
      if @player.cards.length.zero?
        winner
        break
      end
      if @deck.length <= 3
        @log.info { 'Reshuffling deck' }
        @deck = Deck.new(@players.length / 8)
        @deck.shuffle
      end
      if @top_card.penalized.nil?
        case @top_card.internal_value
        when 10 # Reverse
          change_direction
          @top_card.penalized = true
        when 11 # Skip
          increment_player
          @top_card.penalized = true
        else
          'nothing' # Rubocop is dumb
        end
      end
      increment_player
    end
  end

  def draw_card
    @deck.draw_card
  end

  def increment_player
    @current_player += @direction
    @current_player = (@total_players - 1) if @current_player.negative?
    @current_player = 0 if @current_player >= @total_players
    @player = @players[@current_player]
    @current_player
  end

  def change_direction
    @log.info { 'Reversing Direction' }
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
    @players.collect { |player| @total_points += player.points }
    @total_points
  end

  def winner
    @log.warn { "Player #{@player.name} Won!" }
    @players.each do |player|
      @log.warn { "Player #{player.name} had #{player.points} points." }
    end
    @log.warn { "Total Points: #{points}" }
    @winner = true
    @game_end = Time.now
    @log.warn { "Game took #{@game_end - @game_start} seconds." }
  end
end
