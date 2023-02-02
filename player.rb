#!/usr/bin/env ruby

require_relative 'deck'
require 'logger'

# Runo Player
class Player
  attr_accessor :name, :cards, :dealer, :type, :log, :color_playable, :like_playable

  def initialize(log:, name:, dealer:)
    @name = name
    @cards = []
    @dealer = dealer
    @log = log
  end

  def draw_card(num_cards = 1)
    num_cards.times do
      @cards << @dealer.draw_card
      @log.info { "Player #{@name} drew a #{@cards.last}" }
    end
  end

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

  def which_card(top_card)
    @color_playable = color_playable(top_card)
    return @color_playable.last unless @color_playable.empty?

    @like_playable = like_playable(top_card)
    return @like_playable.last unless @like_playable.empty? || (top_card.point_value == 50)

    wild_cards = @cards.find_all { |card| card.color == 4 }
    wild_card = wild_cards.first unless wild_cards.empty?
    wild_card.color = preferred_color unless wild_card.nil?
    return wild_card unless wild_card.nil?  # Seriously Rubocop? 'Might be unitialized' yeah you mean it might be nil?

    nil
  end

  def color_playable(top_card)
    @log.info { "Color Playable: Top Card Color = #{COLORS[top_card.color]}" }
    @log.info { "Color Playable: #{self.to_s}" }
    @cards.find_all { |card| card.color == top_card.color }
  end

  def like_playable(top_card)
    @cards.find_all { |card| card.internal_value == top_card.internal_value }
  end

  def preferred_color
    colors = {}
    (0..4).each do |color|
      colors[color] = 0
    end
    @cards.collect { |card| colors[card.color] += card.point_value }
    # nil out black, 'cause we don't want to pick it
    colors.delete(4)
    colors = colors.sort_by { |_, val| val}
    @log.info { "Player #{name} played wild card and prefers #{COLORS[colors.last[0]]}" }
    colors.last[0]
  end

  def points
    @total_points = 0
    @cards.collect { |card| @total_points += card.point_value }
    @total_points
  end

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
