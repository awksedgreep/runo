#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'player'
require_relative 'deck'
require_relative 'card'
require 'logger'
require 'pry'

# to play
# game = Dealer.new(log: log, players: ['Mark', 'Wesley', 'Josh', 'Mingjia'])
class Dealer
  # deck array
  attr_accessor :deck
  # player array
  attr_accessor :players
  # card play current direction
  attr_accessor :direction
  # who's turn is it
  attr_accessor :turn
  # who is the current player
  attr_accessor :current_player
  # logger object
  attr_accessor :log
  # how many players in the current game
  attr_accessor :total_players
  # how many total points at end of game
  attr_accessor :total_points
  # time the game started
  attr_accessor :game_start
  # time the game finished
  attr_accessor :game_finish

  # Create dealer, deck, add players
  def initialize(log:, players:)
    game_init(log, players)
    play_game
  end

  # Create a game, deck, shuffle, and deal cards
  def game_init(log, players)
    @log = log
    create_deck(players.length / 8)
    create_players(players)
    deal_cards
    set_defaults
    @top_card = @deck.draw_card
    @current_player = 0
    @player = @players[@current_player]
  end

  # Set some instance defaults for one game
  def set_defaults
    @game_start = Time.now
    @winner = false
    @direction = 1 # start with forward direction
    @direction_name = 'Forward'
    @total_players = @players.length
  end

  # Create the card deck and shuffle it
  def create_deck(card_decks)
    @deck = Deck.new(@log, card_decks)
    @log.info { "Shuffling Deck: #{@deck.length} cards" }
    @deck.shuffle
  end

  # Create the player objects
  def create_players(players)
    @players = []
    players.each do |player|
      @players << Player.new(log: @log, name: player, dealer: self)
    end
  end

  # Deal cards to the players
  def deal_cards
    @log.info { 'Dealing Cards' }
    7.times do
      @players.each(&:draw_card)
    end
  end

  # Play one game of uno
  def play_game
    initial_card_rules
    until @winner
      before_turn
      lay_down = @player.play_card(@top_card)
      @top_card = lay_down unless lay_down.nil?
      log_after_turn(lay_down)
      break if winner

      after_turn
    end
  end

  # Log some initial pre turn data
  def log_before_turn
    @log.info { "It's #{@player.name}'s Turn: Direction =  #{@direction_name}" }
    @log.info { "Before turn: #{@player}" }
    @log.info { "Top card #{@top_card}" }
  end

  # Log status after player's turn
  def log_after_turn(lay_down)
    @log.info { "Player #{@player.name} could not lay down" } if lay_down.nil?
    @log.info { "Player #{@player.name} played #{lay_down}" } unless lay_down.nil?
    @log.info { "Player #{@player.name} now has #{@player.cards.length} cards" }
    @log.info { "After turn: #{@player}" }
  end

  # before we start our turn, do we need to handle any special cards
  def before_turn
    log_before_turn
    return if @top_card.penalized.nil?

    draw_four if @top_card.internal_value == 14 # Draw Four
    draw_two if @top_card.internal_value == 12 # Draw Two
  end

  # Draw four has been played
  def draw_four
    @log.info { "Player #{@player.name} drawing 4 cards" }
    @player.draw_card(4)
    @top_card.penalized = true
    increment_player
  end

  # Draw two has been played
  def draw_two
    @log.info { "Player #{@player.name} drawing 2 cards" }
    @player.draw_card(2)
    @top_card.penalized = true
    increment_player
  end

  # Reverse has been played
  def reverse
    @log.info { 'Reverse played, inverting direction' }
    change_direction
    @top_card.penalized = true
  end

  # Skip card has been played
  def skip
    @log.info { 'Skip played, skipping one player' }
    increment_player
    @top_card.penalized = true
  end

  # After lay down complete, we need to see if special cards need to be addressed
  def after_turn
    if @top_card.penalized.nil?
      reverse if @top_card.internal_value == 10 # Reverse
      skip if @top_card.internal_value == 11 # Skip
    end
    increment_player
  end

  # Published rules for what to do if top card is reverse, skip, wild, etc
  def initial_card_rules
    # if reverse or skip handle first card
    change_direction if @top_card.internal_value == 10 # 10 = Reverse
    increment_player if @top_card.internal_value == 11 # 11 = Skip
    # if wild card have first player pick color
    @top_card.color = @player.preferred_color if @top_card.color == 4
  end

  # draw one card from the deck and return it
  def draw_card
    @deck.draw_card
  end

  # next player in the current direction
  def increment_player
    @current_player += @direction
    @current_player = (@total_players - 1) if @current_player.negative?
    @current_player = 0 if @current_player >= @total_players
    @player = @players[@current_player]
    @current_player
  end

  # reverse direction
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

  # points in the remaining players hands
  def points
    @total_points = 0
    @players.collect { |player| @total_points += player.points }
    @total_points
  end

  # return winner of the game
  def winner
    return if @player.cards.length.positive?

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
