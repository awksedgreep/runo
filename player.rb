#!/usr/bin/env ruby

require 'deck'

class Player
  attr_accessor :name, :cards, :dealer, :type
  
  def initialize(name, dealer)
    @name = name
    @cards = []
    @dealer = dealer
  end
  
  def draw_card(num_cards = 1)
    @cards << @dealer.draw_card
  end
  
  def play_card(top_card)
    result = which_card(top_card)
    if result.nil? # Can't play?
      draw_card
      to_s
      result = which_card(top_card)
    end
    @cards.delete(result) unless result.nil?
    return result unless result.nil?
  end
  
  def which_card(top_card)
    color_playable = @cards.find_all {|card| card.color == top_card.color }
    like_playable = @cards.find_all {|card| card.internal_value == top_card.internal_value }
    wild_cards = @cards.find_all {|card| card.color == 4 }
    color_playable = color_playable.sort_by {|card| card.point_value } unless color_playable.empty?
    like_playable = like_playable.sort_by {|card| card.point_value } unless (like_playable.empty? or top_card.point_value == 50)
    wild_cards = wild_cards.sort_by {|card| card.internal_value } unless wild_cards.empty?
    return color_playable.last unless color_playable.empty?
    return like_playable.last unless (like_playable.empty? or top_card.point_value == 50)
    wild_card = wild_cards.first unless wild_cards.empty?
    wild_card.color = preferred_color unless wild_card.nil?
    return wild_card unless wild_card.nil?
  end
  
  def preferred_color
    colors = {}
    (0..4).each do |color|
      colors[color] = 0
    end
    @cards.collect {|card| colors[card.color] += card.point_value }
    # nil out black, 'cause we don't want to pick it
    colors.delete(4)
    colors = colors.sort_by {|color, val| val}
    puts "Player #{name.red.bold} played wild card and prefers #{COLORS[colors.last[0]].send(COLORS[colors.last[0]].downcase).bold}"
    colors.last[0]
  end
  
  def points
    @total_points = 0
    @cards.collect {|card| @total_points += card.point_value }
    @total_points
  end
  
  def to_s
    if @cards.empty?
      "Player " + @name.red.bold + " has no cards"
    else 
      result = "Player " + @name.red.bold + " Has " + @cards.length.to_s + " cards:  "
      @cards.each do |card|
        result += card.to_s + " "
      end
      result
    end
  end
end