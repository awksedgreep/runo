# frozen_string_literal: true

require_relative 'deck'
require_relative 'colorize'
require 'logger'

# Runo Player
class Player
  # player's name
  attr_accessor :name
  # cards in his hand
  attr_accessor :cards
  # current dealer
  attr_accessor :dealer
  # player type
  attr_accessor :type
  # logging object
  attr_accessor :log
  # matching color playable cards in hand
  attr_accessor :color_playable
  # like playable cards in hand
  attr_accessor :like_playable

  # create new player
  def initialize(log:, name:, dealer:)
    @name = name
    @cards = []
    @dealer = dealer
    @log = log
  end

  # draw a card from the deck
  def draw_card(num_cards = 1)
    num_cards.times do
      @cards << @dealer.draw_card
      @log.info { "Player #{@name} drew a #{@cards.last}" }
    end
  end

  # play a card if you can (color/like match)
  def play_card(top_card)
    result = which_card(top_card)
    if result.nil? # Can't play?
      @log.info { "Player #{@name} Can't play" }
      draw_card
      result = which_card(top_card)
    end
    @cards.delete(result) unless result.nil?
    result unless result.nil?
  end

  # determine if player has a card they can play
  def which_card(top_card)
    @color_playable = find_color_playable(top_card)
    return @color_playable.last unless @color_playable.empty?

    @like_playable = find_like_playable(top_card)
    return @like_playable.last unless @like_playable.empty? || (top_card.point_value == 50)

    wild_cards = @cards.find_all { |card| card.color == 4 }
    wild_card = wild_cards.first unless wild_cards.empty?
    wild_card.color = preferred_color unless wild_card.nil?
    return wild_card unless wild_card.nil? # Seriously Rubocop? 'Might be unitialized' yeah you mean it might be nil?

    nil
  end

  # which of my cards match top card
  def find_color_playable(top_card)
    @log.info { "Color Playable: Top Card Color = #{RunoCards::COLORS[top_card.color]}" }
    @log.info { "Color Playable: #{self}" }
    @cards.find_all { |card| card.color == top_card.color }
  end

  # which of my cards match value of top card
  def find_like_playable(top_card)
    @cards.find_all { |card| card.internal_value == top_card.internal_value }
  end

  # player just played a wild card and prefers color ?
  def preferred_color
    colors = {}
    5.times { |color| colors[color] = 0 }
    @cards.collect { |card| colors[card.color] += card.point_value }
    colors.delete(4) # nil out black, 'cause we don't want to pick it
    colors = colors.sort_by { |_, val| val }
    @log.info { "Player #{name} played wild card and prefers #{RunoCards::COLORS[colors.last[0]]}" }
    colors.last[0]
  end

  # player currently has cards worth x points
  def points
    @total_points = 0
    @cards.collect { |card| @total_points += card.point_value }
    @total_points
  end

  # string representation of player
  def to_s
    if @cards.empty?
      "Player #{@name} has no cards"
    else
      result = "Player #{@name} has #{@cards.length} cards:  "
      @cards.each do |card|
        result += "#{card} "
      end
      result
    end
  end
end
